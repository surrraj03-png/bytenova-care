/**
 * ByteNova Care – Dashboard Interactions
 * Team ByteNova | University Hackathon
 * Controls sidebar switching, modal interactions, prescription views
 */

// Modal Management
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }
}

// Close modal when clicking on background backdrop
window.addEventListener('click', function (e) {
    if (e.target.classList.contains('modal-overlay')) {
        e.target.classList.remove('active');
        document.body.style.overflow = '';
    }
});

// Dashboard Tab Switching (for single-page feel without reload)
function switchDashTab(tabId, element) {
    // Hide all tab panes
    const panes = document.querySelectorAll('.dash-tab-pane');
    panes.forEach(pane => pane.style.display = 'none');

    // Show target pane
    const target = document.getElementById(tabId);
    if (target) {
        target.style.display = 'block';
    }

    // Update active nav link
    if (element) {
        const links = document.querySelectorAll('.dash-nav-link');
        links.forEach(l => l.classList.remove('active'));
        element.classList.add('active');
    }
}

// Print Prescription helper
function printPrescription(rxId) {
    const printContent = document.getElementById(rxId);
    if (!printContent) return;

    const win = window.open('', '', 'height=700,width=850');
    win.document.write('<html><head><title>ByteNova Care – OPD Prescription</title>');
    win.document.write('<style>');
    win.document.write('body { font-family: "Segoe UI", Arial, sans-serif; padding: 30px; color: #1E293B; }');
    win.document.write('.header { border-bottom: 2px solid #0B2545; padding-bottom: 12px; margin-bottom: 20px; display: flex; justify-content: space-between; }');
    win.document.write('.brand { font-size: 24px; font-weight: bold; color: #0B2545; }');
    win.document.write('.tagline { font-size: 12px; color: #0D9488; }');
    win.document.write('table { width: 100%; border-collapse: collapse; margin-top: 15px; }');
    win.document.write('th, td { border: 1px solid #CBD5E1; padding: 8px 12px; text-align: left; }');
    win.document.write('th { background-color: #F1F5F9; }');
    win.document.write('.rx-box { margin-top: 20px; padding: 15px; border: 1px dashed #0D9488; background: #F8FAFC; white-space: pre-wrap; }');
    win.document.write('.footer { margin-top: 40px; border-top: 1px solid #E2E8F0; padding-top: 15px; font-size: 11px; color: #64748B; display: flex; justify-content: space-between; }');
    win.document.write('</style></head><body>');
    win.document.write(printContent.innerHTML);
    win.document.write('<div class="footer"><div>ByteNova Care – Smart Healthcare. Better Care.</div><div>Developed by Team ByteNova</div></div>');
    win.document.write('</body></html>');
    win.document.close();
    win.focus();
    win.print();
    win.close();
}

// Setup doctor prescribe modal trigger
function setupDoctorPrescribe(apptId, patientName, patientId, uhid, symptoms) {
    document.getElementById('prescribeApptId').value = apptId;
    document.getElementById('prescribePatientId').value = patientId;
    document.getElementById('modalPatientName').textContent = patientName + ' (' + uhid + ')';
    document.getElementById('modalPatientSymptoms').textContent = symptoms;
    openModal('prescribeModal');
}
