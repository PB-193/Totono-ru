document.addEventListener("DOMContentLoaded", () => {
  const todayButton = document.getElementById("today-button");
  const visitDayField = document.getElementById("visit-day-field");
  todayButton.addEventListener("click", () => {
    const today = new Date().toISOString().split("T")[0];
    visitDayField.value = today;
  });
});
