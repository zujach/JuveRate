import { useState } from "react";
import logo from "../assets/logo.png";
import "./Navbar.css";

function Navbar() {
    const [isMenuOpen, setIsMenuOpen] = useState(false);

    function closeMenu() {
        setIsMenuOpen(false);
    }

    return (
        <nav className="navbar">
            <a href="/" className="logo" onClick={closeMenu}>
                <img src={logo} alt="JuveRate" className="logo-image" />
            </a>

            <button
                type="button"
                className="menu-toggle"
                aria-label={isMenuOpen ? "Zamknij menu" : "Otwórz menu"}
                aria-expanded={isMenuOpen}
                aria-controls="navbar-menu"
                onClick={() => setIsMenuOpen((open) => !open)}
            >
                <span aria-hidden="true">{isMenuOpen ? "×" : "☰"}</span>
            </button>

            <div
                id="navbar-menu"
                className={`navbar-menu${isMenuOpen ? " is-open" : ""}`}
            >
                <div className="nav-links">
                    <a href="/koncerty" onClick={closeMenu}>Koncerty</a>
                    <a href="#festiwale" onClick={closeMenu}>Festiwale</a>
                    <a href="#ranking" onClick={closeMenu}>Ranking</a>
                </div>

                <a href="#logowanie" className="login-button" onClick={closeMenu}>
                    Zaloguj się
                </a>
            </div>
        </nav>
    );
}

export default Navbar;