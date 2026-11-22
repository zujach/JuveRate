import "./Footer.css";

function Footer() {
    return (
        <footer className="footer">
            <div className="footer-content">
                <div className="footer-brand">
                    <h2>JuveRate</h2>
                    <p>
                        Twoje wspomnienia. Twoje opinie.
                        <br />
                        Wszystko, co dzieje się pod sceną.
                    </p>
                </div>

                <div className="footer-links">
                    <h3>Odkrywaj</h3>
                    <a href="#koncerty">Koncerty</a>
                    <a href="#opinie">Opinie</a>
                    <a href="#ranking">Ranking</a>
                </div>

                <div className="footer-links">
                    <h3>JuveRate</h3>
                    <a href="#o-nas">O nas</a>
                    <a href="#kontakt">Kontakt</a>
                    <a href="#regulamin">Regulamin</a>
                </div>
            </div>

            <div className="footer-bottom">
                <p>© 2026 JuveRate. Wszystkie prawa zastrzeżone.</p>
                <p>Tworzone z pasji do muzyki.</p>
            </div>
        </footer>
    );
}

export default Footer;
