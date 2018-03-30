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
    myid: {
      type: Number,
      default: -1
    }
  },
  data: function () {
    return {
      memo: 'hi vue2!',
      rateValue: "1",
      readOnly: false,
      memoShow: false
    }
  },
  methods: {
    ratecheck: function (event) {
      rateValue = $("[name=rating]:checked").val()
      console.info(rateValue)
    },
    showhide: function (event) {
      if (this.memoShow) {
        this.memoShow = false;
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
    rateValue: function (val) {
      // $('input[name=rating]:eq({{rateValue}})').prop('checked', true);
      console.info("myid is:"+ this.myid);
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
    width: 75px;
    height: 15px;
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
