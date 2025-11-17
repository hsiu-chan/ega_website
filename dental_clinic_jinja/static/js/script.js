// 表單前端小功能：Formspree 處理與回饋
document.addEventListener('DOMContentLoaded', function(){
  const form = document.getElementById('appointmentForm');
  const result = document.getElementById('formResult');
  if(!form) return;

  form.addEventListener('submit', function(e){
    e.preventDefault();
    result.textContent = '送出中…';
    const data = new FormData(form);
    const action = form.action;
    fetch(action, {
      method: 'POST',
      body: data,
      headers: {'Accept':'application/json'}
    }).then(response=>{
      if(response.ok){
        result.textContent = '已收到您的預約，我們會盡快聯絡您。';
        form.reset();
      } else {
        response.json().then(json=>{
          if(json && json.error) result.textContent = json.error;
          else result.textContent = '送出失敗，請稍後再試。';
        }).catch(()=>{ result.textContent = '送出失敗，請稍後再試。' });
      }
    }).catch(err=>{
      console.error(err);
      result.textContent = '網路錯誤，請稍後再試。';
    });
  });
});
