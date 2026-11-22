import { Star, UserRound } from "lucide-react";
import "./ReviewCard.css";

function ReviewCard({ review }) {
    return (
        <article className="review-card">
            <div className="review-header">
                <div className="review-avatar">
                    <UserRound size={22} />
                </div>

                <div className="review-author">
                    <h3>{review.author}</h3>
                    <span>{review.festival}</span>
                </div>
            </div>

            <div className="review-rating">
                {Array.from({ length: 5 }, (_, index) => (
                    <Star
                        key={index}
                        size={17}
                        fill={index < review.rating ? "currentColor" : "none"}
                    />
                ))}
                <span>{review.rating}/5</span>
            </div>

            <p className="review-text">„{review.text}”</p>

            <p className="review-artist">{review.artist}</p>
        </article>
    );
}

export default ReviewCard;
