import logo from "../assets/logo.png";
import "./Navbar.css";

function Navbar() {
    return (
        <nav className="navbar">

            <a href="/" className="logo">
                <img src={logo} alt="JuveRate" className="logo-image" />
            </a>

            <div className="nav-links">
                <a href="/koncerty">Koncerty</a>
                <a href="#festiwale">Festiwale</a>
                <a href="#ranking">Ranking</a>
            </div>

            <a href="#logowanie" className="login-button">
                Zaloguj się
            </a>

        </nav>
    );
}

export default Navbar;
