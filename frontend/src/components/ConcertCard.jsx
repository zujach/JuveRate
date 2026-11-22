import { Star, CalendarDays } from "lucide-react";
import { Link } from "react-router-dom";
import "./ConcertCard.css";

function ConcertCard({ concert }) {
    return (
        <article className="concert-card">
            <div className="concert-image">
                <img src={concert.image} alt={concert.artist} />
                <div className="concert-rating">
                    <Star size={16} fill="currentColor" />
                    <span>{concert.rating}</span>
                </div>
            </div>

            <div className="concert-info">
                <p className="concert-festival">{concert.festival}</p>

                <h3>{concert.artist}</h3>

                <div className="concert-date">
                    <CalendarDays size={16} />
                    <span>{concert.date}</span>
                </div>

                <Link
                    to={`/koncerty/${concert.id}`}
                    className="concert-card-button"
                >
                    Zobacz opinie
                </Link>
            </div>
        </article>
    );
}

export default ConcertCard;
