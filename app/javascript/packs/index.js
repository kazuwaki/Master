/* global $*/
//診断機能
$(document).on('turbolinks:load', function() {
  if(document.URL.match(/about/)){
	$(function () {
    const buttons = document.querySelectorAll(".btn")
    for(const button of buttons) {
      button.addEventListener("click", function() {
        const currentDiv = button.closest("div");
        currentDiv.style.display = "none";
        const id = button.getAttribute("href");
        const nextDiv = document.querySelector(id);
        nextDiv.classList.add("fit");
    		nextDiv.style.display = "block";
		  })
		}
	});
}
//topページのアニメーション
  $(function(){
    ScrollReveal().reveal('.box', {
      duration: 2000,
      scale: 4,
      reset: false
    });
  });

  //任意のタブにURLからリンクするための設定
  function GethashID (hashIDName){
    if(hashIDName){
      //タブ設定
      $('.tab li').find('a').each(function() { //タブ内のaタグ全てを取得
        const idName = $(this).attr('href'); //タブ内のaタグのリンク名
        if(idName == hashIDName){ //リンク元の指定されたURLのハッシュタグ
          const parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
          $('.tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
          $(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
          //表示させるエリア設定
          $(".area").removeClass("is-active"); //もともとついているis-activeクラスを取り除き
          $(hashIDName).addClass("is-active"); //表示させたいエリアのタブリンク名をクリックしたら、表示エリアにis-activeクラスを追加
        }
      });
    }
  }

  //タブをクリックしたら
  $('.tab a').on('click', function() {
    const idName = $(this).attr('href'); //タブ内のリンク名を取得
    GethashID (idName);//設定したタブの読み込みと
    return false;//aタグを無効にする
  });
});

document.addEventListener("turbolinks:load", () => {
    function scrollToEnd() {
        const messageDetails = document.getElementById('chat-area');
        messageDetails.scrollTop = messageDetails.scrollHeight;
        //console.log("ここ通過");
    }
    scrollToEnd()
})

