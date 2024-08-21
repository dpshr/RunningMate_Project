function submitForm(actionUrl) {
	const form = document.querySelector('form[action="userForm"]');
	form.action = actionUrl;
	form.submit();
}