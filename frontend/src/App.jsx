import { BrowserRouter, Routes, Route } from "react-router-dom";
import { useEffect } from "react";
import { useLocation } from "react-router-dom";
import Navbar from "./components/Navbar";
import Hero from "./components/Hero";
import Home from "./pages/Home";
import Concerts from "./pages/Concerts";
import Footer from "./components/Footer";
import ConcertDetails from "./pages/ConcertDetails";

function App() {
    function ScrollToTop() {
        const { pathname } = useLocation();

        useEffect(() => {
            window.scrollTo(0, 0);
        }, [pathname]);

        return null;
    }

    return (
        <BrowserRouter>
            <ScrollToTop />
            <div className="app">
                <Navbar />

                <div className="main-content">
                    <Routes>
                        <Route
                            path="/"
                            element={
                                <>
                                    <Hero />
                                    <Home />
                                </>
                            }
                        />

                        <Route path="/koncerty" element={<Concerts />} />
                        <Route path="/koncerty/:id" element={<ConcertDetails />} />
                    </Routes>
                </div>

                <Footer />
            </div>
        </BrowserRouter>
    );
}

export default App;
