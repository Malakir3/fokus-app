if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function() {
    const ImageList = document.getElementById('image-list');
    
    // 選択した画像を表示する関数
    const createImageHTML = (blob) => {

      // div要素を生成し、何個目の要素なのかをカウントする
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class', "image-element");
      let imageElementNum = document.querySelectorAll('.image-element').length

      // プレビュー画像のimg要素を生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('width', '150');
      blobImage.setAttribute('height', 'auto');

      // ファイル選択ボタン（input要素）を生成
      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('id', `menu-image-${imageElementNum}`);
      inputHTML.setAttribute('name', 'menu[images][]');
      inputHTML.setAttribute('type', 'file');

      // 画像挿入用要素に、生成したdiv要素（img要素、input要素）を挿入
      imageElement.appendChild(inputHTML);
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);

      // 再度、画像とファイル選択ボタンが表示される処理
      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob);
      });
    };
      
    document.getElementById('menu-image').addEventListener('change', (e) => {
      let file = e.target.files[0];
      let blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}