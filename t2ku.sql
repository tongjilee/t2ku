--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE authors (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    slug character varying(255)
);


ALTER TABLE public.authors OWNER TO super;

--
-- Name: authors_books; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE authors_books (
    author_id integer,
    book_id integer
);


ALTER TABLE public.authors_books OWNER TO super;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authors_id_seq OWNER TO super;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE authors_id_seq OWNED BY authors.id;


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('authors_id_seq', 1, true);


--
-- Name: books; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE books (
    id integer NOT NULL,
    title character varying(255),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    slug character varying(255)
);


ALTER TABLE public.books OWNER TO super;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO super;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE books_id_seq OWNED BY books.id;


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('books_id_seq', 1, true);


--
-- Name: books_users; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE books_users (
    book_id integer,
    user_id integer
);


ALTER TABLE public.books_users OWNER TO super;

--
-- Name: definitions; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE definitions (
    id integer NOT NULL,
    description text,
    code text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    regexp_code text
);


ALTER TABLE public.definitions OWNER TO super;

--
-- Name: definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE definitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.definitions_id_seq OWNER TO super;

--
-- Name: definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE definitions_id_seq OWNED BY definitions.id;


--
-- Name: definitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('definitions_id_seq', 1, true);


--
-- Name: items; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE items (
    id integer NOT NULL,
    book_id integer,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    item_id integer,
    itemizable_id integer,
    itemizable_type character varying(255),
    slug character varying(255),
    rank double precision
);


ALTER TABLE public.items OWNER TO super;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_id_seq OWNER TO super;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE items_id_seq OWNED BY items.id;


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('items_id_seq', 7, true);


--
-- Name: pfeed_deliveries; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE pfeed_deliveries (
    id integer NOT NULL,
    pfeed_receiver_id integer,
    pfeed_receiver_type character varying(255),
    pfeed_item_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.pfeed_deliveries OWNER TO super;

--
-- Name: pfeed_deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE pfeed_deliveries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pfeed_deliveries_id_seq OWNER TO super;

--
-- Name: pfeed_deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE pfeed_deliveries_id_seq OWNED BY pfeed_deliveries.id;


--
-- Name: pfeed_deliveries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('pfeed_deliveries_id_seq', 1, false);


--
-- Name: pfeed_items; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE pfeed_items (
    id integer NOT NULL,
    type character varying(255),
    originator_id integer,
    originator_type character varying(255),
    participant_id integer,
    participant_type character varying(255),
    data text,
    expiry timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.pfeed_items OWNER TO super;

--
-- Name: pfeed_items_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE pfeed_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pfeed_items_id_seq OWNER TO super;

--
-- Name: pfeed_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE pfeed_items_id_seq OWNED BY pfeed_items.id;


--
-- Name: pfeed_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('pfeed_items_id_seq', 1, false);


--
-- Name: problems; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE problems (
    id integer NOT NULL,
    name character varying(255),
    description text,
    code text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.problems OWNER TO super;

--
-- Name: problems_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE problems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.problems_id_seq OWNER TO super;

--
-- Name: problems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE problems_id_seq OWNED BY problems.id;


--
-- Name: problems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('problems_id_seq', 1, false);


--
-- Name: robots; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE robots (
    id integer NOT NULL,
    user_id integer,
    name character varying(255),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.robots OWNER TO super;

--
-- Name: robots_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE robots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.robots_id_seq OWNER TO super;

--
-- Name: robots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE robots_id_seq OWNED BY robots.id;


--
-- Name: robots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('robots_id_seq', 1, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO super;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    user_id integer,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    canonical_form character varying(1000)
);


ALTER TABLE public.tasks OWNER TO super;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO super;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('tasks_id_seq', 2, true);


--
-- Name: theorems; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE theorems (
    id integer NOT NULL,
    name character varying(255),
    description text,
    code text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.theorems OWNER TO super;

--
-- Name: theorems_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE theorems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.theorems_id_seq OWNER TO super;

--
-- Name: theorems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE theorems_id_seq OWNED BY theorems.id;


--
-- Name: theorems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('theorems_id_seq', 1, false);


--
-- Name: users; Type: TABLE; Schema: public; Owner: super; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(128) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255),
    website character varying(255),
    location character varying(255),
    signature text,
    slug character varying(255)
);


ALTER TABLE public.users OWNER TO super;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: super
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO super;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: super
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: super
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE authors ALTER COLUMN id SET DEFAULT nextval('authors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE definitions ALTER COLUMN id SET DEFAULT nextval('definitions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE pfeed_deliveries ALTER COLUMN id SET DEFAULT nextval('pfeed_deliveries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE pfeed_items ALTER COLUMN id SET DEFAULT nextval('pfeed_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE problems ALTER COLUMN id SET DEFAULT nextval('problems_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE robots ALTER COLUMN id SET DEFAULT nextval('robots_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE theorems ALTER COLUMN id SET DEFAULT nextval('theorems_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: super
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: super
--

COPY authors (id, name, description, created_at, updated_at, slug) FROM stdin;
1	Paolo Aluffi	\N	2011-11-24 08:54:46.808321	2011-11-24 08:54:46.808321	paolo-aluffi
\.


--
-- Data for Name: authors_books; Type: TABLE DATA; Schema: public; Owner: super
--

COPY authors_books (author_id, book_id) FROM stdin;
1	1
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: super
--

COPY books (id, title, description, created_at, updated_at, slug) FROM stdin;
1	Algebra: Chapter 0	Algebra: Chapter 0 is a self-contained introduction to the main topics of algebra, suitable for a first sequence on the subject at the beginning graduate or upper undergraduate level. The primary distinguishing feature of the book, compared to standard textbooks in algebra, is the early introduction of categories, used as a unifying theme in the presentation of the main topics. A second feature consists of an emphasis on homological algebra: basic notions on complexes are presented as soon as modules have been introduced, and an extensive last chapter on homological algebra can form the basis for a follow-up introductory course on the subject. Approximately 1,000 exercises both provide adequate practice to consolidate the understanding of the main body of the text and offer the opportunity to explore many other topics, including applications to number theory and algebraic geometry. This will allow instructors to adapt the textbook to their specific choice of topics and provide the independent reader with a richer exposure to algebra. Many exercises include substantial hints, and navigation of the topics is facilitated by an extensive index and by hundreds of cross-references.\r\n	2011-11-24 08:54:46.795978	2011-11-24 08:54:46.795978	algebra-chapter-0
\.


--
-- Data for Name: books_users; Type: TABLE DATA; Schema: public; Owner: super
--

COPY books_users (book_id, user_id) FROM stdin;
1	1
\.


--
-- Data for Name: definitions; Type: TABLE DATA; Schema: public; Owner: super
--

COPY definitions (id, description, code, created_at, updated_at, name, regexp_code) FROM stdin;
1	\N	?tilt:ReflexivityRelation :- ?tilt:EquivalenceRelation.\r\n?tilt:SymmetryRelation :- ?tilt:EquivalenceRelation.\r\n?tilt:TransitivityRelation :- ?tilt:EquivalenceRelation.	2011-11-25 08:11:45.344661	2011-11-25 10:14:08.193587	Equivalence Relation	Let /\\d+ be an equivalence relation on \\d+/ do |it,set|\r\n  flora2("#{it}:EquivalenceRelation[base_set->#{set}].")\r\nend
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: super
--

COPY items (id, book_id, name, created_at, updated_at, item_id, itemizable_id, itemizable_type, slug, rank) FROM stdin;
4	1	Dedication	2011-11-24 09:08:37.380227	2011-11-24 10:18:05.440477	\N	\N		dedication	0.100000000000000006
6	1	Introduction	2011-11-24 09:08:37.41531	2011-11-24 10:18:30.885288	\N	\N		introduction	0.200000000000000011
3	1	Chapter I. Preliminaries: Set theory and categories	2011-11-24 09:08:37.364506	2011-11-24 10:19:33.40875	\N	\N		chapter-i-preliminaries-set-theory-and-categories	1
1	1	$\\S$1. Naive Set theory	2011-11-24 09:06:49.414029	2011-11-24 10:25:08.865114	3	\N		s-1-naive-set-theory	1.10000000000000009
2	1	1.1. Sets	2011-11-24 09:08:37.311973	2011-11-24 10:25:27.825514	1	\N		1-1-sets	1.1100000000000001
\.


--
-- Data for Name: pfeed_deliveries; Type: TABLE DATA; Schema: public; Owner: super
--

COPY pfeed_deliveries (id, pfeed_receiver_id, pfeed_receiver_type, pfeed_item_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: pfeed_items; Type: TABLE DATA; Schema: public; Owner: super
--

COPY pfeed_items (id, type, originator_id, originator_type, participant_id, participant_type, data, expiry, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: problems; Type: TABLE DATA; Schema: public; Owner: super
--

COPY problems (id, name, description, code, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: robots; Type: TABLE DATA; Schema: public; Owner: super
--

COPY robots (id, user_id, name, description, created_at, updated_at) FROM stdin;
1	1	Adios	The first automated reasoning robot of T2Ku.	2011-11-25 02:43:17.185214	2011-11-25 02:44:19.260237
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: super
--

COPY schema_migrations (version) FROM stdin;
20111120120841
20111122130706
20111122130707
20111124094947
20111125023105
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: super
--

COPY tasks (id, user_id, description, created_at, updated_at, canonical_form) FROM stdin;
1	1	Let $G$ be a group,\r\n    $e$ be the identity of $G$,\r\n    $*$ be the binary operation of $G$.\r\nSuppose that\r\n    $x*x=e$ for all $x\\in G$.\r\nProve that\r\n    $G$ is commutative.	2011-11-24 00:36:33.020398	2011-11-24 00:36:33.020398	\N
2	1	Let $G$ be a group,\r\n    $e$ be the identity of $G$,\r\n    $*$ be the binary operation of $G$.\r\nSuppose that\r\n    $x*x=e$ for all $x\\in G$.\r\nProve that\r\n    $G$ is commutative.\r\n	2011-11-25 10:22:37.845051	2011-11-25 10:22:37.845051	\N
\.


--
-- Data for Name: theorems; Type: TABLE DATA; Schema: public; Owner: super
--

COPY theorems (id, name, description, code, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: super
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, created_at, updated_at, name, website, location, signature, slug) FROM stdin;
1	pmq2001@gmail.com	$2a$10$boVrfVOkD2xiqyjbG3OEjuNUwHCNggQzHGCm/iDIPk7LXdY26vVae	\N	\N	\N	17	2011-11-25 06:34:40.642807	2011-11-25 03:22:11.710231	127.0.0.1	127.0.0.1	\N	2011-11-23 07:04:55.640891	2011-11-23 07:04:23.376893	2011-11-23 07:04:23.377213	2011-11-25 06:39:57.848314	P.S.V.R			I hate algebra.	p-s-v-r
\.


--
-- Name: authors_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY definitions
    ADD CONSTRAINT definitions_pkey PRIMARY KEY (id);


--
-- Name: items_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: pfeed_deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY pfeed_deliveries
    ADD CONSTRAINT pfeed_deliveries_pkey PRIMARY KEY (id);


--
-- Name: pfeed_items_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY pfeed_items
    ADD CONSTRAINT pfeed_items_pkey PRIMARY KEY (id);


--
-- Name: problems_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY problems
    ADD CONSTRAINT problems_pkey PRIMARY KEY (id);


--
-- Name: robots_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY robots
    ADD CONSTRAINT robots_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: theorems_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY theorems
    ADD CONSTRAINT theorems_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: super; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_authors_on_slug; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX index_authors_on_slug ON authors USING btree (slug);


--
-- Name: index_books_on_slug; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX index_books_on_slug ON books USING btree (slug);


--
-- Name: index_items_on_slug; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX index_items_on_slug ON items USING btree (slug);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_slug; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_slug ON users USING btree (slug);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: super; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: pg
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM pg;
GRANT ALL ON SCHEMA public TO pg;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

