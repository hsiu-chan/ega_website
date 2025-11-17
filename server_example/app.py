# Flask + SendGrid example (server-side email)
# NOTE: This is optional. GitHub Pages cannot run server code.
# To use: deploy to any Python web host (Heroku / Fly / Render / GCP Cloud Run)
from flask import Flask, request, jsonify
import os
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

app = Flask(__name__)

@app.route('/api/appointment', methods=['POST'])
def appointment():
    data = request.form
    name = data.get('name')
    phone = data.get('phone')
    email = data.get('email')
    date = data.get('date')
    message = data.get('message')

    sg_api_key = os.getenv('SENDGRID_API_KEY')
    if not sg_api_key:
        return jsonify({'error':'SendGrid API key not configured'}), 500

    content = f"New appointment:\\nName: {name}\\nPhone: {phone}\\nEmail: {email}\\nDate: {date}\\nMessage: {message}"
    mail = Mail(from_email='no-reply@example.com', to_emails='clinic@example.com', subject='New Appointment', plain_text_content=content)
    try:
        sg = SendGridAPIClient(sg_api_key)
        response = sg.send(mail)
        return jsonify({'ok':True}), 200
    except Exception as e:
        return jsonify({'error':str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
