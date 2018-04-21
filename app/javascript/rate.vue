<template>
  <div class="star-rating-frame">
    <div>
      <span class="star-rating">
          <input type="radio" name="rating" value="1" v-model="rateValue"><i></i>
          <input type="radio" name="rating" value="2" v-model="rateValue"><i></i>
          <input type="radio" name="rating" value="3" v-model="rateValue"><i></i>
          <input type="radio" name="rating" value="4" v-model="rateValue"><i></i>
          <input type="radio" name="rating" value="5" v-model="rateValue"><i></i>
      </span>
      <i class="fas fa-comment" v-on:click="showhide"></i>
      <i class="fas fa-eraser" v-on:click="clearValue"></i>
    </div>
    <div>
    <textarea id="memo" cols="50" rows="3" v-show="memoShow" v-model="memo"></textarea>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    scorableId: {
      type: Number
    },
    scorableType: {
      type: String
    }
  },
  data: function () {
    return {
      memo: '',
      rateValue: "0",
      readOnly: false,
      memoShow: false
    }
  },
  mounted: function () {  // mounted が良いか、createdが良いか・・・？
    this.rateGet()
  },
  methods: {
    rateGet: function () {
      console.info('loadValue pushed.');
      axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content');
      axios.post('/scores.json', {
        scorable_type: this.scorableType,
        scorable_id: this.scorableId
      } )
        .then((response) => {
          console.debug('memo:' + response.data.memo );
          console.debug('rateValue:' + response.data.value );
          if( response.data.memo != null)
          {
            this.memo = response.data.memo;
          }
          if( response.data.value != null )
          {
            this.rateValue = response.data.value;
          }
        })
        .catch((error) => {
          console.error(error);
        });
    },
    ratePatch: function () {
      console.debug("scorableId is:"+ this.scorableId);
      console.debug('rateValue: '+ this.rateValue);
      console.debug('memo: '+ this.memo);
      axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content');
      axios.patch('/scores/'+ this.scorableId+'.json', {
        value: this.rateValue,
        memo: this.memo,
      })
      .then((response) => {
        console.log(response);
      })
      .catch((error) => {
        console.log(error);
      });
    },
    showhide: function (event) {
      if (this.memoShow) {
        this.memoShow = false;
        console.debug("scorableId is:"+ this.scorableId);
        console.debug('memo: '+ this.memo);
        axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content');
        axios.patch('/scores/'+ this.scorableId+'.json', {
          memo: this.memo
        })
        .then((response) => {
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
      } else {
        this.memoShow = true;
      }
    },
    clearValue: function (event) {
      this.memo = "";
      this.rateValue = 0;
    }
  },
  watch: {
    memo: function (val) {
      // memo は、閉じるときにPatchする
      // 
    },
    rateValue: function (val) {
      this.ratePatch();
    }
  }
}
</script>

<style scoped>
/* for debug */
  .star-rating-frame {
    border:0px dotted;
    border-color:#226655;
  }

  .star-rating {
    font-size: 0;
    white-space: nowrap;
    display: inline-block;
    /* width = height*5 で設定すると、☆がきれいに見える */
    width: 100px;
    height: 20px;
    overflow: hidden;
    position: relative;
    background: url('data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IiB3aWR0aD0iMjBweCIgaGVpZ2h0PSIyMHB4IiB2aWV3Qm94PSIwIDAgMjAgMjAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDIwIDIwIiB4bWw6c3BhY2U9InByZXNlcnZlIj48cG9seWdvbiBmaWxsPSIjREREREREIiBwb2ludHM9IjEwLDAgMTMuMDksNi41ODMgMjAsNy42MzkgMTUsMTIuNzY0IDE2LjE4LDIwIDEwLDE2LjU4MyAzLjgyLDIwIDUsMTIuNzY0IDAsNy42MzkgNi45MSw2LjU4MyAiLz48L3N2Zz4=');
    background-size: contain;
  }
  .star-rating i {
    opacity: 0;
    position: absolute;
    left: 0;
    top: 0;
    height: 100%;
    width: 20%;
    z-index: 1;
    background: url('data:image/svg+xml;base64,PHN2ZyB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IiB3aWR0aD0iMjBweCIgaGVpZ2h0PSIyMHB4IiB2aWV3Qm94PSIwIDAgMjAgMjAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDIwIDIwIiB4bWw6c3BhY2U9InByZXNlcnZlIj48cG9seWdvbiBmaWxsPSIjRkZERjg4IiBwb2ludHM9IjEwLDAgMTMuMDksNi41ODMgMjAsNy42MzkgMTUsMTIuNzY0IDE2LjE4LDIwIDEwLDE2LjU4MyAzLjgyLDIwIDUsMTIuNzY0IDAsNy42MzkgNi45MSw2LjU4MyAiLz48L3N2Zz4=');
    background-size: contain;
  }
  .star-rating input {
    -moz-appearance: none;
    -webkit-appearance: none;
    opacity: 0;
    display: inline-block;
    width: 20%;
    height: 100%;
    margin: 0;
    padding: 0;
    z-index: 2;
    position: relative;
  }
  .star-rating input:hover + i,
  .star-rating input:checked + i {
    opacity: 1;
  }
  .star-rating i ~ i {
    width: 40%;
  }
  .star-rating i ~ i ~ i {
    width: 60%;
  }
  .star-rating i ~ i ~ i ~ i {
    width: 80%;
  }
  .star-rating i ~ i ~ i ~ i ~ i {
    width: 100%;
  }
  .choice {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    text-align: center;
    padding: 20px;
    display: block;
  }
</style>
