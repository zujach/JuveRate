import { useParams } from "react-router-dom";
import { Star, CalendarDays, Music2 } from "lucide-react";
import concerts from "../data/concerts";
import reviews from "../data/reviews";
import ReviewCard from "../components/ReviewCard";

import "./ConcertDetails.css";

function ConcertDetails() {
    const { id } = useParams();

    const concert = concerts.find(
        (item) => item.id === Number(id)
    );

    if (!concert) {
        return (
            <main className="concert-details-page">
                <h1>Nie znaleziono koncertu</h1>
                <p>Wybrany koncert nie istnieje.</p>
            </main>
        );
    }

    const concertReviews = reviews.filter(
        (review) => review.artist === concert.artist
    );

    return (
        <main className="concert-details-page">
            <section className="concert-details-header">
                <img
                    src={concert.image}
                    alt={concert.artist}
                    className="concert-details-image"
                />

                <div className="concert-details-info">
                    <p className="section-label">{concert.festival}</p>

                    <h1>{concert.artist}</h1>

                    <p className="concert-details-date">
                        <CalendarDays size={18} />
                        {concert.date}
                    </p>

                    <p className="concert-details-rating">
                        <Star size={20} fill="currentColor" />
                        {concert.rating} / 5
                    </p>
                </div>
            </section>

            <section className="concert-details-reviews">
                <div className="section-heading">
                    <div>
                        <p className="section-label">GŁOS UCZESTNIKÓW</p>
                        <h2>Opinie o koncercie</h2>
                        <p className="section-description">
                            Sprawdź, jak inni wspominają ten występ.
                        </p>
                    </div>

                    <span className="reviews-count">
            {concertReviews.length} opinii
          </span>
                </div>

                {concertReviews.length > 0 ? (
                    <div className="review-grid">
                        {concertReviews.map((review) => (
                            <ReviewCard key={review.id} review={review} />
                        ))}
                    </div>
                ) : (
                    <div className="no-concert-reviews">
                        <Music2 size={35} />
                        <h3>Brak opinii o tym koncercie</h3>
                        <p>
                            Bądź pierwszy i podziel się swoimi wrażeniami!
                        </p>
                    </div>
                )}
            </section>
        </main>
    );
}

export default ConcertDetails;
