// Load header and footer
function loadComponent(url, elementId) {
  if (document.getElementById(elementId)) {
    fetch(url)
      .then(response => response.text())
      .then(data => {
        document.getElementById(elementId).innerHTML = data;
      })
      .catch(error => console.error(`Ошибка загрузки ${url}:`, error));
  }
}

// Загружаем компоненты только если они существуют на странице
loadComponent('header.html', 'header-placeholder');
loadComponent('footer.html', 'footer-placeholder');
loadComponent('header.html', 'header');
loadComponent('footer.html', 'footer');

// Phone form submission - только если форма существует
const phoneForm = document.getElementById('phoneForm');
if (phoneForm) {
  phoneForm.addEventListener('submit', function (e) {
    e.preventDefault();
    const phoneStep = document.getElementById('phoneStep');
    const codeStep = document.getElementById('codeStep');
    const code1 = document.getElementById('code1');
    
    if (phoneStep) phoneStep.classList.add('d-none');
    if (codeStep) codeStep.classList.remove('d-none');
    if (code1) code1.focus();
  });
}

// Code input auto-focus - только если инпуты существуют
const codeInputs = document.querySelectorAll('.code-input');
if (codeInputs.length > 0) {
  codeInputs.forEach((input, index) => {
    input.addEventListener('input', function () {
      if (this.value.length === 1 && index < codeInputs.length - 1) {
        const nextInput = codeInputs[index + 1];
        if (nextInput) nextInput.focus();
      }
    });

    input.addEventListener('keydown', function (e) {
      if (e.key === 'Backspace' && this.value === '' && index > 0) {
        const prevInput = codeInputs[index - 1];
        if (prevInput) prevInput.focus();
      }
    });
  });
}

// Resend code button - только если кнопка существует
const resendBtn = document.getElementById('resendBtn');
if (resendBtn && codeInputs.length > 0) {
  resendBtn.addEventListener('click', function () {
    alert('Новый код отправлен!');
    codeInputs.forEach(input => input.value = '');
    if (codeInputs[0]) codeInputs[0].focus();
  });
}

function toggleSection(sectionName) {
  const content = document.getElementById(sectionName + 'Content');
  const arrow = document.getElementById(sectionName + 'Arrow');

  if (content && arrow) {
    if (content.style.display === 'none') {
      content.style.display = 'block';
      arrow.textContent = '▼';
    } else {
      content.style.display = 'none';
      arrow.textContent = '▶';
    }
  }
}

// Функции для модальных окон
function openPortfolioModal(card) {
  const modal = document.getElementById('portfolioModal');
  const dropdown = document.getElementById('portfolioModalDropdown');
  if (modal) modal.style.display = 'flex';
  if (dropdown) dropdown.style.display = 'flex';
}

function openServiceModal(card) {
  const modal = document.getElementById('serviceModal');
  const dropdown = document.getElementById('serviceModalDropdown');
  if (modal) modal.style.display = 'flex';
  if (dropdown) dropdown.style.display = 'flex';
}

function closeModalOnOverlay(event, modalId) {
  if (event.target.classList.contains('modal-overlay')) {
    const modal = document.getElementById(modalId);
    if (modal) modal.style.display = 'none';
  }
}

function savePortfolio() {
  alert('Портфолио сохранено!');
  const modal = document.getElementById('portfolioModal');
  const dropdown = document.getElementById('portfolioModalDropdown');
  if (modal) modal.style.display = 'none';
  if (dropdown) dropdown.style.display = 'none';
}

function deletePortfolio() {
  if (confirm('Удалить работу из портфолио?')) {
    alert('Работа удалена!');
    const modal = document.getElementById('portfolioModal');
    const dropdown = document.getElementById('portfolioModalDropdown');
    if (modal) modal.style.display = 'none';
    if (dropdown) dropdown.style.display = 'none';
  }
}

function saveService() {
  alert('Услуга сохранена!');
  const modal = document.getElementById('serviceModal');
  const dropdown = document.getElementById('serviceModalDropdown');
  if (modal) modal.style.display = 'none';
  if (dropdown) dropdown.style.display = 'none';
}

function deleteService() {
  if (confirm('Удалить услугу?')) {
    alert('Услуга удалена!');
    const modal = document.getElementById('serviceModal');
    const dropdown = document.getElementById('serviceModalDropdown');
    if (modal) modal.style.display = 'none';
    if (dropdown) dropdown.style.display = 'none';
  }
}

// Переключение роли - только если кнопки существуют
const roleButtons = document.querySelectorAll('.role-btn');
if (roleButtons.length > 0) {
  roleButtons.forEach(btn => {
    btn.addEventListener('click', function () {
      roleButtons.forEach(b => b.classList.remove('active'));
      this.classList.add('active');
    });
  });
}

// FAQ аккордеон - только если элементы существуют
let questions = document.querySelectorAll('.question');
let answers = document.querySelectorAll('.answer');

if (questions.length > 0 && answers.length > 0) {
  questions.forEach((question, index) => {
    question.onclick = () => {
      questions[index].classList.toggle('active');
      answers[index].classList.toggle('active');
    };
  });
}

let menubtn = document.querySelector('.menu-btn');

if (menubtn) {
  menubtn.onclick = () => {
    document.querySelector('.nav-menu').classList.toggle('active');
  };
}

let ids = document.querySelectorAll('.id');
let admIdMenus = document.querySelectorAll('.adm-id-menu');

if (ids.length > 0 && admIdMenus.length > 0) {
  ids.forEach((id, index) => {
    id.onclick = () => {
      ids[index].classList.toggle('active');
      admIdMenus[index].classList.toggle('active');
    };
  });
}