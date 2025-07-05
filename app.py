from flask import Flask, request, send_file, render_template_string
import pdfkit
import tempfile

# Ruta local de wkhtmltopdf en Windows (ajusta si es necesario)
config = pdfkit.configuration(wkhtmltopdf='/usr/bin/wkhtmltopdf')

app = Flask(__name__)

@app.route('/generar_pdf', methods=['POST'])
def generar_pdf():
    datos = request.json
    if not datos:
        return {"error": "No se enviaron datos"}, 400

    with open("plantilla.html", "r", encoding="utf-8") as f:
        html_template = f.read()

    html_rendered = render_template_string(html_template, **datos)

    tmp_pdf = tempfile.NamedTemporaryFile(delete=False, suffix=".pdf")
    pdfkit.from_string(html_rendered, tmp_pdf.name, configuration=config)

    return send_file(tmp_pdf.name, as_attachment=True, download_name="contrato.pdf")

if __name__ == '__main__':
    app.run()
