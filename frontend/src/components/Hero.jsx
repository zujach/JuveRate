import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Search } from "lucide-react";
import "./Hero.css";

function Hero() {
    const [searchQuery, setSearchQuery] = useState("");
    const navigate = useNavigate();

    const handleSearch = (e) => {
        e.preventDefault();

        navigate(`/koncerty?search=${encodeURIComponent(searchQuery)}`);
    };

    return (
        <section className="hero">
            <div className="hero-content">
                <p className="hero-label">TWOJE WSPOMNIENIA. TWOJE OPINIE.</p>

                <h1>
                    Jak było
                    <br />
                    pod sceną?
                </h1>

                <p className="hero-description">
                    Sprawdź opinie o koncertach, podziel się swoimi wrażeniami
                    i znajdź wydarzenia, których nie możesz przegapić.
                </p>

                <form className="hero-search" onSubmit={handleSearch}>
                    <Search size={21} />

                    <input
                        type="text"
                        placeholder="Wyszukaj koncert lub artystę..."
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                    />

                    <button type="submit">Szukaj</button>
                </form>
            </div>
        </section>
    );
}

export default Hero;
