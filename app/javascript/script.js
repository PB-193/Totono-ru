document.addEventListener("DOMContentLoaded", () => {
  const todayButton = document.getElementById("today-button");
  const visitDayField = document.getElementById("content_visit_day");

  todayButton.addEventListener("click", (event) => {
    event.preventDefault();
    const today = new Date().toISOString().split("T")[0];
    visitDayField.value = today;
  });
});
