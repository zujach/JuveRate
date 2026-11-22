import { useState } from "react";
import { useSearchParams } from "react-router-dom";
import { Search } from "lucide-react";
import concerts from "../data/concerts";
import ConcertCard from "../components/ConcertCard";
import "./Concerts.css";

function Concerts() {
    const [searchParams] = useSearchParams();

    const [searchQuery, setSearchQuery] = useState(
        searchParams.get("search") || ""
    );

    const [selectedFestival, setSelectedFestival] = useState("Wszystkie festiwale");

    const filteredConcerts = concerts.filter((concert) => {
        const query = searchQuery.toLowerCase();

        const matchesSearch =
            concert.artist.toLowerCase().includes(query) ||
            concert.festival.toLowerCase().includes(query);

        const matchesFestival =
            selectedFestival === "Wszystkie festiwale" ||
            concert.festival === selectedFestival;

        return matchesSearch && matchesFestival;
    });

    return (
        <main className="concerts-page">
            <section className="concerts-header">
                <p className="section-label">ODKRYWAJ MUZYKĘ</p>
                <h1>Wszystkie koncerty</h1>
                <p>
                    Znajdź swoich ulubionych artystów, sprawdź oceny
                    i poznaj opinie uczestników.
                </p>

                <div className="concerts-search">
                    <Search size={21} />
                    <input
                        type="text"
                        placeholder="Wyszukaj artystę lub festiwal..."
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                    />
                </div>
                <div className="festival-filter">
                    <label htmlFor="festival-select">Filtruj według festiwalu:</label>

                    <select
                        id="festival-select"
                        value={selectedFestival}
                        onChange={(e) => setSelectedFestival(e.target.value)}
                    >
                        <option value="Wszystkie festiwale">Wszystkie festiwale</option>
                        <option value="Juwenalia Krakowskie">Juwenalia Krakowskie</option>
                        <option value="jUKENalia">jUKENalia</option>
                        <option value="Juwenalia UEK">Juwenalia UEK</option>
                    </select>
                </div>
            </section>

            <section className="concerts-list">
                <div className="concerts-list-heading">
                    <h2>Odkryj wydarzenia</h2>
                    <span>
            {filteredConcerts.length} koncertów
          </span>
                </div>

                {filteredConcerts.length > 0 ? (
                    <div className="concert-grid">
                        {filteredConcerts.map((concert) => (
                            <ConcertCard
                                key={concert.id}
                                concert={concert}
                            />
                        ))}
                    </div>
                ) : (
                    <div className="no-concerts">
                        <h3>Nie znaleziono koncertów</h3>
                        <p>
                            Spróbuj wpisać inną nazwę artysty lub festiwalu.
                        </p>
                    </div>
                )}
            </section>
        </main>
    );
}

export default Concerts;
