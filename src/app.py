from flask import Flask, render_template, request
from pyswip import Prolog

app = Flask(__name__)
app.jinja_env.globals.update(enumerate=enumerate)  # Dodanie enumerate do kontekstu Jinja2

prolog = Prolog()
prolog.consult("questions.pl")

pytania = [
    'Czy popierasz integrację europejską?',
    'Czy wspierasz prawa człowieka?',
    'Czy jesteś za tradycyjnymi wartościami?',
    'Czy popierasz ochronę środowiska?',
    'Czy wspierasz gospodarkę rynkową?',
    'Czy jesteś za gospodarką mieszaną?',
    'Czy popierasz inwestycje publiczne?',
    'Czy wspierasz obronę narodową?',
    'Czy jesteś za gospodarką socjalną?',
    'Czy wspierasz prawa pracownicze?',
    'Czy popierasz opiekę zdrowotną?',
    'Czy jesteś za niskimi podatkami?',
    'Czy wspierasz deregulację?',
    'Czy popierasz innowacje?',
    'Czy jesteś za suwerennością narodową?',
    'Czy wspierasz wolny rynek?',
    'Czy popierasz równouprawnienie?',
    'Czy jesteś za zwiększeniem regulacji rynku pracy?',
    'Czy wspierasz ochronę prywatności?',
    'Czy popierasz działania na rzecz zmian klimatycznych?'
]

partie = {
    'pis': 'Prawo i Sprawiedliwość',
    'po': 'Koalicja Obywatelska',
    'lewica': 'Lewica',
    'psl': 'Polskie Stronnictwo Ludowe',
    'konfederacja': 'Konfederacja'
}

@app.route('/')
def index():
    return render_template('index.html', pytania=pytania)

@app.route('/wynik', methods=['POST'])
def wynik():
    prolog.query("clear_answers")
    
    for i, pytanie in enumerate(pytania):
        odp = request.form.get(f'pytanie_{i}')
        prolog_query = f"answer({i+1}, 'user', '{odp}')"
        list(prolog.query(prolog_query))
    
    partia_query = list(prolog.query("match_party('user', Party)"))
    
    if partia_query:
        partia = partia_query[0]['Party']
        partia_name = partie.get(partia, "Nie znaleziono odpowiedniej partii")
    else:
        partia_name = "Nie znaleziono odpowiedniej partii"
    
    return render_template('wynik.html', partia=partia_name)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
