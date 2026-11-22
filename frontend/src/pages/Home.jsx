import concerts from "../data/concerts";
import reviews from "../data/reviews";
import ConcertCard from "../components/ConcertCard";
import ReviewCard from "../components/ReviewCard";
import "./Home.css";

function Home() {
    return (
        <main>
            <section className="featured-concerts" id="koncerty">
                <div className="section-heading">
                    <div>
                        <p className="section-label">NIE PRZEGAP</p>
                        <h2>Polecane koncerty</h2>
                        <p className="section-description">
                            Sprawdź, co działo się na scenach i poznaj opinie innych.
                        </p>
                    </div>

                    <a href="/koncerty" className="all-concerts-link">
                        Zobacz wszystkie →
                    </a>
                </div>

                <div className="concert-grid">
                    {concerts.map((concert) => (
                        <ConcertCard key={concert.id} concert={concert} />
                    ))}
                </div>
            </section>

            <section className="featured-reviews" id="opinie">
                <div className="section-heading">
                    <div>
                        <p className="section-label">GŁOS UCZESTNIKÓW</p>
                        <h2>Oni już byli pod sceną</h2>
                        <p className="section-description">
                            Poznaj wrażenia innych i sprawdź, co warto zobaczyć.
                        </p>
                    </div>
                </div>

                <div className="review-grid">
                    {reviews.map((review) => (
                        <ReviewCard key={review.id} review={review} />
                    ))}
                </div>
            </section>
        </main>
    );
}

export default Home;
