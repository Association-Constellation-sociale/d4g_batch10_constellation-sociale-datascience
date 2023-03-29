--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1

-- Started on 2023-03-27 11:02:08 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 16389)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 853 (class 1247 OID 16400)
-- Name: QualificationTypeEnum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."QualificationTypeEnum" AS ENUM (
    'context',
    'appreciation',
    'noun',
    'action'
);


ALTER TYPE public."QualificationTypeEnum" OWNER TO postgres;

--
-- TOC entry 856 (class 1247 OID 16410)
-- Name: RoleEnum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."RoleEnum" AS ENUM (
    'admin',
    'user',
    'representative'
);


ALTER TYPE public."RoleEnum" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16460)
-- Name: Answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Answer" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "questionId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Answer" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16558)
-- Name: AnswerTranslation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AnswerTranslation" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "answerText" character varying NOT NULL,
    "isOriginalAnswer" boolean DEFAULT false NOT NULL,
    "languageId" uuid NOT NULL,
    "answerId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."AnswerTranslation" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16578)
-- Name: Language; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Language" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Language" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16469)
-- Name: Qualification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Qualification" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "answerId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Qualification" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16568)
-- Name: QualificationTranslation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QualificationTranslation" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "languageId" uuid NOT NULL,
    type public."QualificationTypeEnum" NOT NULL,
    token character varying NOT NULL,
    "precision" character varying NOT NULL,
    occurence integer NOT NULL,
    "isOriginalQualification" boolean DEFAULT false NOT NULL,
    "qualificationId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."QualificationTranslation" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16450)
-- Name: Question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Question" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "userId" uuid NOT NULL,
    "themeId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "isOpenThemeQuestion" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Question" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16548)
-- Name: QuestionTranslation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionTranslation" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "questionText" character varying NOT NULL,
    "isOriginalQuestion" boolean DEFAULT false NOT NULL,
    "languageId" uuid NOT NULL,
    "questionId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."QuestionTranslation" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16417)
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Role" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    role public."RoleEnum" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Role" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16433)
-- Name: Theme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Theme" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "isSelected" boolean DEFAULT false NOT NULL,
    "userId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Theme" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16538)
-- Name: ThemeTranslation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ThemeTranslation" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "themeName" character varying NOT NULL,
    "isOriginalTheme" boolean DEFAULT false NOT NULL,
    "languageId" uuid NOT NULL,
    "themeId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."ThemeTranslation" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16424)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "firstName" character varying NOT NULL,
    "lastName" character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    "roleId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "commonLanguageId" uuid NOT NULL,
    "culturalLanguageId" uuid NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16478)
-- Name: Validation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Validation" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    difficulty integer NOT NULL,
    efficiency integer NOT NULL,
    "takenTime" integer NOT NULL,
    "answerId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Validation" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16443)
-- Name: Vote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Vote" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "themeId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Vote" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16390)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 3465 (class 0 OID 16460)
-- Dependencies: 220
-- Data for Name: Answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Answer" (id, "questionId", "userId", "createdAt", "updatedAt") FROM stdin;
d87e4045-d981-4deb-88f4-77ce32399e3b	adf3efcf-3d18-4676-8193-6db5e083c5ad	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
e98b7495-3019-42fa-80fb-363468a82ac2	7ed380ab-12bd-4185-8b4a-e7254bab5e10	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
52da8df5-b0d1-46fc-9e17-828723aaeb63	b275c684-6970-4ed3-bb22-d22ef3d9c59a	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
e727b6c6-b90d-42a9-887b-35106ace7898	07bb5ed0-e638-4258-819d-973686881a39	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
3c884f25-df39-4f76-888d-36120a7cf6fe	8cce9cea-808f-487c-a24e-1dcf03985f44	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
64fbe717-6af0-49d7-9737-1b5d5869573a	adf3efcf-3d18-4676-8193-6db5e083c5ad	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
df7d167f-2318-4c24-87d2-df796ff4254d	7ed380ab-12bd-4185-8b4a-e7254bab5e10	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
17ac63c5-0682-44fa-83c8-cf87a9980bea	b275c684-6970-4ed3-bb22-d22ef3d9c59a	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
438a9193-6803-4b83-b6c2-15b78ea9a293	07bb5ed0-e638-4258-819d-973686881a39	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
dec5b050-ac80-4a0d-a52b-4ed0c54641ae	8cce9cea-808f-487c-a24e-1dcf03985f44	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
994216b4-1b02-4fbe-a72d-ab9fbc99d636	adf3efcf-3d18-4676-8193-6db5e083c5ad	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
20de7465-c67b-4358-b4f6-842518854d8a	adf3efcf-3d18-4676-8193-6db5e083c5ad	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
56258c7b-a6bf-4c78-80e2-310a0b941146	7ed380ab-12bd-4185-8b4a-e7254bab5e10	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
847c9b44-395d-43d5-90f4-cdea416c4cb1	7ed380ab-12bd-4185-8b4a-e7254bab5e10	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.827	2023-03-24 18:03:29.827
31c628a6-63a8-4d48-a32f-8d70ff243b4f	b275c684-6970-4ed3-bb22-d22ef3d9c59a	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
14899068-d2be-4cee-9cbc-ab3ae406c473	b275c684-6970-4ed3-bb22-d22ef3d9c59a	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.844	2023-03-24 18:03:29.844
a82abf72-d80c-4099-aaef-470ff25f74f8	07bb5ed0-e638-4258-819d-973686881a39	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
d4e5888e-1e65-4d2c-890f-6ecb4ff0053c	07bb5ed0-e638-4258-819d-973686881a39	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
47a90be1-6239-43c3-8039-8f6e3aaafb79	8cce9cea-808f-487c-a24e-1dcf03985f44	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
4ed9ecf1-8c3a-42d1-a044-14c0644d09e2	8cce9cea-808f-487c-a24e-1dcf03985f44	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:29.882	2023-03-24 18:03:29.882
a59fdb1b-20b8-4787-b037-b4c7d063867d	ebb2c446-395f-478e-8276-cf9bd8736504	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
d0b19555-f46b-4ea7-96de-ebca0fd8db32	6053e34b-204b-4cbc-be67-7d6bf468c594	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
ad64b9b0-98b5-4b69-b88e-e600fee48bed	b09e1c34-5179-4ad4-812a-64f19acf04ba	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
33d101aa-6867-4149-99ab-878b2e088115	2a2c46f6-716a-4277-90e0-aaf19b6edd2f	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
8d779087-cc37-47a8-9b69-991ed819f398	1042f7a3-ae18-4ff3-bef1-bf27ece76b6e	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	ebb2c446-395f-478e-8276-cf9bd8736504	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
5a150c6e-65c0-482f-819a-3b3e0b4db770	6053e34b-204b-4cbc-be67-7d6bf468c594	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
672e0f91-1a66-4a05-a614-076179532d30	b09e1c34-5179-4ad4-812a-64f19acf04ba	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
84f55ba3-2a76-4bbd-bf50-481a0d9884b2	2a2c46f6-716a-4277-90e0-aaf19b6edd2f	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.102	2023-03-24 18:03:30.102
43900fc2-65fb-4d28-bad7-2371c2acb3df	1042f7a3-ae18-4ff3-bef1-bf27ece76b6e	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
e78431bd-ac5a-4c43-976e-a221089ba775	ebb2c446-395f-478e-8276-cf9bd8736504	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
2d40ba5b-d1e4-4eef-91ea-2b42813e1f3f	ebb2c446-395f-478e-8276-cf9bd8736504	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.186	2023-03-24 18:03:30.186
1d418da6-7840-4db4-b346-d93c5b4c72ec	6053e34b-204b-4cbc-be67-7d6bf468c594	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	b09e1c34-5179-4ad4-812a-64f19acf04ba	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
bb427bb5-16d6-45be-9219-af673da92879	b09e1c34-5179-4ad4-812a-64f19acf04ba	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.228	2023-03-24 18:03:30.228
33f7c393-31b0-4a60-b999-bf83a35968c7	2a2c46f6-716a-4277-90e0-aaf19b6edd2f	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
78b891ea-af71-46a0-9bae-484a2cac0335	2a2c46f6-716a-4277-90e0-aaf19b6edd2f	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
c6ebe65a-194f-4e85-bb49-e15d89705677	1042f7a3-ae18-4ff3-bef1-bf27ece76b6e	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
23dabc22-e363-4d28-8be9-450ea93ac194	1042f7a3-ae18-4ff3-bef1-bf27ece76b6e	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.286	2023-03-24 18:03:30.286
34cf8453-d60e-4aac-a508-32e6fa4b0a45	98876855-5737-4e81-a74c-c15b9e3b3a92	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
0b40373e-963a-4ce7-8a7c-85b58c2eeb2b	fbf4ddcb-3278-49e3-968a-6fff4263f130	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
d0ddeff3-e631-438d-909f-ab7f9d05a7af	4eefe735-93d2-46ed-93ad-660b3dc286fb	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
eaf0a27d-1221-4190-9200-417dd1973833	ce9d2562-1bf9-4944-adaa-f3860f7d6223	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
1757aea7-7e07-4a79-85d0-92a92e27571a	026120a2-063a-40f3-94b3-53a1a88ae708	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
faaeec35-02de-4f2c-b122-d14f5098830f	98876855-5737-4e81-a74c-c15b9e3b3a92	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	fbf4ddcb-3278-49e3-968a-6fff4263f130	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
5e80a7d4-ad75-4d2f-9524-0f15436552ad	4eefe735-93d2-46ed-93ad-660b3dc286fb	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
062e8bb1-0bff-4063-a666-da5a3a50a668	ce9d2562-1bf9-4944-adaa-f3860f7d6223	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	026120a2-063a-40f3-94b3-53a1a88ae708	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
61147bd9-7701-41da-bfc1-cf66b91ee029	98876855-5737-4e81-a74c-c15b9e3b3a92	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
172802c0-27ac-4224-a3a1-d02693572025	98876855-5737-4e81-a74c-c15b9e3b3a92	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.651	2023-03-24 18:03:30.651
82191f49-87b3-4a56-896f-869a3e6ad49e	fbf4ddcb-3278-49e3-968a-6fff4263f130	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
92b6b061-18f3-4b2a-abc0-916aee1e6e7b	fbf4ddcb-3278-49e3-968a-6fff4263f130	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.668	2023-03-24 18:03:30.668
b185bd11-bce0-4bfb-a4f2-5f6852e24b59	4eefe735-93d2-46ed-93ad-660b3dc286fb	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.686	2023-03-24 18:03:30.686
e70e48bb-a391-4f47-a82e-fe829d1b98f5	4eefe735-93d2-46ed-93ad-660b3dc286fb	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
332d4983-ffae-4dac-876e-4d86743c1b25	ce9d2562-1bf9-4944-adaa-f3860f7d6223	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
5883cbba-b8ac-4fb7-96e6-aa318ee73d90	ce9d2562-1bf9-4944-adaa-f3860f7d6223	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.71	2023-03-24 18:03:30.71
6e836e15-3511-4b5a-ac9d-ee26412f381f	026120a2-063a-40f3-94b3-53a1a88ae708	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
397b540f-02b4-4973-abd4-b15c26dabbe4	026120a2-063a-40f3-94b3-53a1a88ae708	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.726	2023-03-24 18:03:30.726
d8f63525-be32-4d33-a289-0d74454b8446	211a5198-12e3-416c-ac3c-c71027c2793d	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
1eb2ebff-46df-4318-8576-68bca368fb7a	3c2b2f43-4abf-4f59-a347-8336f479b653	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
5c824c54-b625-41ba-800b-569a324d9330	ee33248a-9125-4a32-91e0-a1e45a67209b	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
9276e06e-d1e1-4dac-a365-020cf2ee2ad4	c2a30f2a-eb66-41c2-81cd-99122f664698	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
04ec782f-1d50-44a9-a943-c94310cfd30f	c808858d-7de5-40d6-9abe-6377e457a278	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
f6004e34-e1ee-4f64-b869-ffcee06d3cdc	211a5198-12e3-416c-ac3c-c71027c2793d	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
b0a379b6-be02-461d-bc10-337027334944	3c2b2f43-4abf-4f59-a347-8336f479b653	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
4b25c4c6-f9fa-479e-b60a-0676ab3daf31	ee33248a-9125-4a32-91e0-a1e45a67209b	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
0ee55124-e1b4-47c2-9768-a09a76aaa822	c2a30f2a-eb66-41c2-81cd-99122f664698	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
c44dd0bb-adf0-4387-9331-3aec474f124b	c808858d-7de5-40d6-9abe-6377e457a278	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
0d33f7e9-a80a-4927-a7f0-c6be670b2f74	211a5198-12e3-416c-ac3c-c71027c2793d	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:30.998	2023-03-24 18:03:30.998
4dde4b4e-7079-4603-a1db-e43bdf59d12b	211a5198-12e3-416c-ac3c-c71027c2793d	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
6d6a3915-4f87-49c0-9050-80351256976d	3c2b2f43-4abf-4f59-a347-8336f479b653	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
6398d8fd-e173-4751-ab95-7e03ba3ee868	3c2b2f43-4abf-4f59-a347-8336f479b653	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.023	2023-03-24 18:03:31.023
243ebac3-bd83-4a4a-b9ee-41b90e550d37	ee33248a-9125-4a32-91e0-a1e45a67209b	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
f69b17dd-545d-436c-a1eb-6355fdaf3ffb	ee33248a-9125-4a32-91e0-a1e45a67209b	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.041	2023-03-24 18:03:31.041
9c9b35a8-982d-47cd-89df-9f34e687e4fc	c2a30f2a-eb66-41c2-81cd-99122f664698	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.047	2023-03-24 18:03:31.047
86628d1e-cff0-4a7a-8e36-d19b47358e92	c808858d-7de5-40d6-9abe-6377e457a278	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	8e951538-6548-498c-b3aa-d42dd3bbb6d5	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
5df3ee26-a777-4716-b201-e93ccd7fa64a	e4be3911-6b43-46b2-b41a-1a08e3d88ad8	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:31.117	2023-03-24 18:03:31.117
8a2f711b-8654-44aa-b9e8-527b1e2fe9b5	e101f909-9cbd-45bf-a0ba-99f52739671e	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
c8717ce0-0a07-4f3c-a379-9ca44fccfb39	8585bdfa-1671-471d-aa59-c583edd4171d	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
9ec5af91-84e8-4414-a124-71c15c5a18d8	20cf0f57-3e1e-403d-830b-c65bfe806e21	96601638-0db6-4ebe-bdd2-a4ce9a5fff32	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	8e951538-6548-498c-b3aa-d42dd3bbb6d5	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
a51d29c4-4f54-434a-87d7-f5a408881f48	e4be3911-6b43-46b2-b41a-1a08e3d88ad8	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
90e9d1bd-22bb-4452-8a44-aa3e85051d68	e101f909-9cbd-45bf-a0ba-99f52739671e	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
66f2f1a2-b204-4ca7-8903-afb8e314e86d	8585bdfa-1671-471d-aa59-c583edd4171d	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:31.225	2023-03-24 18:03:31.225
5bd68116-d7b0-4c2e-a355-b214fe8288eb	20cf0f57-3e1e-403d-830b-c65bfe806e21	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
98dbb2c7-912f-4e75-b927-8a46cd1658ce	8e951538-6548-498c-b3aa-d42dd3bbb6d5	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	e4be3911-6b43-46b2-b41a-1a08e3d88ad8	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
0baac6ed-e780-4cc1-a5cd-8ced30f736e5	e101f909-9cbd-45bf-a0ba-99f52739671e	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
a65e328e-96b1-4ef3-a65a-385899998cc5	8585bdfa-1671-471d-aa59-c583edd4171d	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	20cf0f57-3e1e-403d-830b-c65bfe806e21	b11f026f-96b3-4be3-85a9-7640f7d914a6	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
\.


--
-- TOC entry 3470 (class 0 OID 16558)
-- Dependencies: 225
-- Data for Name: AnswerTranslation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AnswerTranslation" (id, "answerText", "isOriginalAnswer", "languageId", "answerId", "createdAt", "updatedAt") FROM stdin;
60d19311-6232-41f2-9c10-d56eb4b2bebb	Lorsqu’un homme voulait épouser une femme, deux solutions s’offraient à lui : la dot et l’échange tête à tête entre les partenaires. S’il s’agissait d’un cadet non marié, c’était au chef de lui trouver une femme et s’il s’agissait d’un homme déjà établi, c’était à lui-même que la charge incombait. Les filles étaient en général mariées dès leur puberté mais, il pouvait arriver qu’elles soient promises dès leur naissance ou lorsque leur mère était enceinte. C’est donc le père qui le plus souvent mariait sa fille sans son consentement. Si elle traversait la puberté sans être mariée, elle pouvait bénéficier d’un mariage.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
576d7f59-bc6d-4f58-b414-68735e72a4dd	L'habillement n'a jamais été une symbolique importante dans le mariage chez les Bulu. Avant le mariage, le couple s'habillait de façon ordinaire, mais proprement. Pendant le mariage, la femme se maquillait simplement, utilisait une couronne de feuilles d’arbres, un collier fait à base de coquilles vides d'escargots et d'autres enjoliveurs naturels pour embellir son habillement. Après le mariage, l'habillement redevenait le même. Cette simplicité a évolué au fil du temps et les couples lors de leurs mariage laissaient leur OBOM, pour se vêtir d'un tissu pagne qu'ils attachaient simplement autour du corps.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
310681ca-aa7c-48b3-93ab-9a2cf9f4d2e5	Celui ou celle qui s'était décidé à organiser un mariage, parfois sur les conseils d'anciens, s'adressait à la femme-chef de mevungu la plus proche du village. Une date était fixée. La femme-chef se chargeait de convoquer les femmes déjà initiées, l'organisatrice préparait une grande quantité de nourriture et du vin de palme et chaque participante apportait de son côté des mets qu'elle avait préparés. Par la suite, la famille du marié remettait la dot à la belle famille. Une fois la dot acceptée, le Chef du village célébrait le mariage et les invités se partageaient les repas sous une ambiance festive, animée par des groupes culturels.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	52da8df5-b0d1-46fc-9e17-828723aaeb63	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
4ad557e3-c8d9-468d-9689-142dba243ddf	C’était au père de prendre l'initiative de marier sa fille. Avant l'arrivée des prêtres, on donnait les femmes comme des chèvres. On les ligotait et on les livrait au cas où elles refusaient. Parfois, la jeune fille ne savait même pas qu’elle était mariée. Son père était parti en voyage. Là-bas, il avait perçu une énorme dot et n'avait rien dit à son retour. Plus tard, arrivait le prétendant. Le mari dotait avec des bikie, qui ne servaient à rien du tout. On pouvait tout de même acheter, avec, une chèvre dont on évaluait à peu près la valeur. Mais l'argent, lui, servait à bien autre chose !	t	a016b260-36f6-4535-b20b-ea7af618ffc3	e727b6c6-b90d-42a9-887b-35106ace7898	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
9643b455-b495-434e-8b11-d333468dbdab	Chez les Bulu, tout est dans le verbe. Proverbes et maîtrise de la langue sont des atouts. Les bulu ont cette particularité du culte des traditions qu'on s'efforce de transmettre à la jeunesse grandissante. Le mariage traditionnel chez les Bulu de nos jours est devenu très onéreux. À chacune des étapes, le futur marié est amené à acheter des présents matériels et à dépenser beaucoup d’argent pour obtenir le consentement de la belle-famille, par ricochet celui de la mariée. Toute chose qui tend à décourager les hommes a pour conséquence l'augmentation du célibat chez les jeunes.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	3c884f25-df39-4f76-888d-36120a7cf6fe	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
6e8ca4ca-c366-44a2-8d89-4d2a24f8bef6	En la actualidad para escoger a la pareja primero entrega al joven  que se case con la señorita. y luego los familiares entregaron al joven ala hermana del joven  como un intercambio, a veces se casan con personas cercanas y otros buscan personas de distancia lejana para unir y ser familia más grande en territorio algunos se huyen del hogar y se unen con la pareja	t	2d585863-97ad-4543-86cf-d83bcc67e635	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
0958456d-7d4b-41f6-8dde-63d528729934	 Hace 60 años atrás para el matrimonio utilizan vestimenta tradicionales elaborados por padres de la pareja para acompañar en noche de matrimonio ,los hombres iban con lanzas hacer cantos de casamiento  y mujeres vestidos de vestimenta tradicional y los niños también. Todos con coronas elaborados con plumas. eso fue despues de contacto con mundo occidental. Antes de eso fue diferente en proceso de matrimonio solo podia casar despues de una mantaza ¿	t	2d585863-97ad-4543-86cf-d83bcc67e635	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
5002cfd7-6686-4219-98ae-d6ee296e5819	En tradicion cultural he  historial waorani  no avido celebracion de ceremonias despues de casamiento una ves se casan y viven. Solo en casamiento se celebran todos. Unidos con familiares de joven y los familiares de la  señorita  cantan cantos de matrimonio de caseria ,del trabajo ,de guerra ,animo en todo los trabajos le regalan lanzas ,coronas shigras. Por su union ala pareja ,le hortigan ala señorita y al joven le castigan para que no comporte mal	t	2d585863-97ad-4543-86cf-d83bcc67e635	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
724b3376-4045-4337-975c-f8db932c773c	En la cultura waorani si un anciano del pueblo te da de casar permanezcan juntos  es como una autoridad  superior  , en actualidad muchos jovenes se alejan del hogar y se unen con la pareja  van de fiesta y asen  casar  son los ancianos que le asen casar  para que aya mas familias en territorio  y sean defensores de la selva	t	2d585863-97ad-4543-86cf-d83bcc67e635	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
d3baa2fb-4770-4673-9845-ab44bbac7b15	La historia real del pueblo waorani en tema de proceso de matrimonio ,Hace mas de 90 años atra antes de civilizacion con mundo occideltal. No ubo pedidos para intercambiar con persona lejanas  de parejas  ,solo podian octener alas mujeres despues de mantaza  con lanzas  asus  padres y madres  despues que quedaban huerfanas podia  el hombre llevar para que pudieran convertir en  sus mujeres asi era el hombre waorani. Solo en venganza podian recuperar lo perdido y  tener mujer en territorio . No ubo tranquilidad entre tribus waorani. Guerra tras Guerra para sobre vivir	t	2d585863-97ad-4543-86cf-d83bcc67e635	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
e2be357f-f582-4f00-ad90-9ee6515d9dff	For the wedding, she or he could choose the person who they loved and their parents also could choose the partner for them instead of choosing by themselves. If he crushed on and wanted to marry her, his parents went and talked with her and her parents but they could reject it if she didn't love him. Sometimes, they  had to marry to the person who they didn't love and some couples didn't even love each other even though they had to marry because of their old believing and they rarely rejected it.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	994216b4-1b02-4fbe-a72d-ab9fbc99d636	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
5dc1ab23-ce65-4a7f-bf5e-6faabc12ed59	For the wedding, she or he could choose the person who they loved and their parents also could choose the partner for them ( their friends' daughter or son) instead of choosing by themselves. If he crush on and want to marry her, his parents go and talk with her and her parents but they can reject it if she doesn't love him. Sometimes, they had to marry to the person who they didn't love ( when boys touched girls' hand or body with the purpose when they crushed on them) and some couples didn't even love each other even though they had to marry because of their old believing ( If a boy touched a girl and suddenly entered her room, it was a shame and it effected her dignity. That's why boy had to take responsibility and if he didn't take responsibility, she could request compensation from him) and they rarely rejected it ( to protect their dignity from getting bad images around their environment and among their friends).	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	20de7465-c67b-4358-b4f6-842518854d8a	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
c1e1b825-8eb0-40a6-ad72-6629814ecdbd	For boys who were from other religions, they could wear plain shirt, Karen shirt and longyi or sarong before and after the wedding , but they had to wear long dress and sarong when they celebrated their wedding if they marry in this village. For boys who were the same religions, they had to wear long dress and sarong during the ceremonies that entering girl's room and the wedding and they could wear only plain shirt and sarong before and after wedding.For girls, they had to change their clothes what long dress to two- outfit parts since boys came and entered their room and they had to wear it the whole of their lives. If they married out side of this village, they could wear whatever they want before, during and after the wedding.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	56258c7b-a6bf-4c78-80e2-310a0b941146	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
b7be0b1e-c030-47a3-a077-918d79ddddc0	For boys who are from other religions ( the people who are Buddhist or Christian or Hindu or Muslim or others) they can wear plain shirt, Karen shirt and longyi or sarong before and after the wedding , but they have to wear long dress and sarong when they celebrate their wedding when they marrie in this village. For boys who are the same religions, they have to wear long dress and sarong during the ceremonies that entering girl's room ( every boy must enter girl's room at night time before marriage and to be legal as husband and wife according to ancient tradition) , the wedding and they can wear only plain shirt and sarong before and after wedding. For girls, they have to change their clothes what long dress to two- outfit parts since boys come and entere their room and they have to wear it the whole of their lives. If they marry out side of this village ( the villages or cities or state that not Gone Thar Phaung Village), they can wear whatever they want (the clothes of other ethnicities, religions and foreign if they wanted and prefer)  before, during and after the wedding.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	847c9b44-395d-43d5-90f4-cdea416c4cb1	2023-03-24 18:03:29.827	2023-03-24 18:03:29.827
59e212ec-a42b-4740-aef7-112bd1c50e52	We could celebrate our weddings in both of our parent's houses. If we didn't want to celebrate it twice, we could choose one of these two sides. If they would like to celebrate wedding ceremonies in Gone Thar Phaung Village, we celebrated wrist tying ceremony for groom and bride and  least three married couples to nine married couples had to tie the threads at their wrists and wish for them. After that, we spent our day happily  by treating the villagers and the people who are we invited in our house and booth. If they would like to marry outside, they could celebrate their weeding without following these traditions.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	31c628a6-63a8-4d48-a32f-8d70ff243b4f	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
6cbe2ec2-790b-4efd-80b4-d19544d9f008	We can celebrate our weddings in both of our parent's houses. If we don't want to celebrate it twice, we can choose one of these two sides. If they would like to celebrate wedding ceremonies in Gone Thar Phaung Village, we celebrate wrist tying ceremony for groom and bride and  least three married couples to nine married couples ( choosing those couples that must marry only once in their lives, they must never divorce with their partners and must not have bad images that betraying their partners)   have to tie the threads at their wrists and wish for them ( to be royal couples, to face together and count on each other in every situation in the whole of their lives like them ). After that, we spend our day happily  by feasting ( rice, only vegetarian currys, vegetarian desserts) the villagers and the people who are we invite in our house and booth (built it with bamboos and leaves for the guests to eat and take a rest when a lot of people came in this wedding and there were not enough places to treat the guests in the house). If they would like to marry outside, they can celebrate their wedding without following these traditions.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	14899068-d2be-4cee-9cbc-ab3ae406c473	2023-03-24 18:03:29.844	2023-03-24 18:03:29.844
b1f02e54-e510-49db-8a4f-ffeec63ca084	Before, we did not have any contract for marring couples to be legal. Parents were the important authorized people for our wedding and for us. It was already legal when both of our parents knew, agree us and  when mainly  the boys came to girl's house and entered her room with permission at night even they hadn't celebrated their wedding yet . Later, we  announced , told to the people who hadn't known step by step by mouths and invited the people  to come our wedding by giving cheroots.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	a82abf72-d80c-4099-aaef-470ff25f74f8	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
e242a39f-be6c-4598-90ca-8658ce1e681b	Before, we did not have any contract ( signing their name on the papers infront of the lawyer or the villages' leaders , their parents and their relatives) for marriage couples to be legal. Parents were the important authorized people ( if they didn't agree and didn't like him , they could reject him and they could call him and his parents in the village leader's house with many authorized people to give compensation for he had done if he had touched her hands or body) for our wedding and for us. It is already legal when both of our parents know, agree us and  when mainly  the boys come to girl's house and enter her room with permission at night even they haven't celebrated their wedding yet . Later, we  announced, told to the people who hadn't known step by step by mouths and invited the people  to come our wedding by giving cheroots ( Burmese traditional cigar and used to use it to invite the guests befor we didn't have any invitation letter).	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	d4e5888e-1e65-4d2c-890f-6ecb4ff0053c	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
44176013-8650-4c2e-802d-5611dd290182	Every boy must enter girl's  room to be wife and husband and we don't limit the people who believe our religion what do not marry to other. They can marry but this couple has to choose one side. If they choose to faith Talah Kone religion, they can stay in this village and they have to marry early as soon as possible because they and their parents can't worship with other people in ceremonies or worship days as long as they don't celebrate the wedding. But, If they stayed outside, their parents could worship with other people even they didn't celebrate their weeding yet.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	47a90be1-6239-43c3-8039-8f6e3aaafb79	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
390cc470-f505-4e7c-8bac-178a0a4d48da	Every boy must enter girl's room to be wife and husband ( according to our tradition, the time that after her parents and she accept his proposing and before they celebrate the wedding) we don't limit the people who believe our religion what do not marry to other ( the people who are foreigners and different ethnicities , different traditions and culture with us). They can marry but this couple has to choose one side. If they choose to faith Talah Kone religion, they can stay in this village  and they have to marry early as soon as possible because they and their parents can't worship with other people( if they don't celebrate their wedding and stay in this village) in ceremonies or worship days as long as they don't celebrate the wedding. But, If they stayed outside, their parents can worship (the declinations of their glory wouldn't spread to them ) with other people even they didn't celebrate their wedding yet.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	4ed9ecf1-8c3a-42d1-a044-14c0644d09e2	2023-03-24 18:03:29.882	2023-03-24 18:03:29.882
080e931c-3156-4874-9ee8-904b48fdd8bf	L’Obom était fabriqué de façon artisanale à base de fines lamelles d’écorces extraites de l’arbre. Ces lamelles étaient trempées dans la rivière afin de les rendre plus tendres et faciles à travailler. Pour les rendre lisses et moins épaisses, l’artisan tapait dessus à l’aide d’un morceau de bois. Elles étaient ensuite étendues au soleil pour s’endurcir et prendre de belles couleurs bois, selon la formation de l'écorce. Le tissu s’entretenait comme tout autre.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
ff3cc2e4-7bf3-4f6a-b0d9-935fda32350e	La culture de la matière première était à la base de la confection des costumes. L’exploitant semait, entretenait puis récoltait les écorces. Ensuite, le filateur prélevait les lamelles de l’arbre à partir de la peau supérieure et les transformait en fil ou tissu. Au préalable, les lamelles étaient successivement débarrassées de leurs impuretés, peignées, étirées, puis tressées. Le tissage permettait d’obtenir des tissus plus rigides, alors que le maillage offrait un résultat plus souple. 	t	a016b260-36f6-4535-b20b-ea7af618ffc3	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
9da7d1b1-c1ea-4c50-b631-e51d3b895aa4	On pouvait teindre soit la lamelle, soit le tissu, soit le produit fini. L’impression d’un motif etait réalisé à la main. On recouvrait la lamelle d’écorce avec des morceaux de bois et on les fixait à l’aide des pinces, la trempait dans le bain de teinture, rinçait, faisait sécher avant de retirer les morceaux de bois. Le soleil permettait de fixer les teintures naturelles. Plus le tissu était trempé longtemps dans le bain de teinture, plus la couleur obtenue était foncée.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	ad64b9b0-98b5-4b69-b88e-e600fee48bed	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
0274616b-2fd0-4ebf-9f12-73e280271375	Avant la couture à proprement parlé, le tissu est préalablement découpé. Les pièces maintenant façonnées, sont prêtes pour l’assemblage. Les derniers détails, tels que la broderie, les étiquettes ou autres enjoliveurs  y sont ensuite apportés. Le style, la forme et les illustrations de nos habits qui permettaient aux vêtements de prendre vie étaient choisis en fonction de la mode à l'époque ou de l'usage du vêtement.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	33d101aa-6867-4149-99ab-878b2e088115	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
dc3d0c24-0bc4-4d8d-8a34-88629f2932a8	Les Bulu réalisaient leur costume avec un tissu traditionnel ancestral appelé OBOM, obtenu à partir d’écorces extraites de différents arbres de notre vaste forêt dense équatoriale et était parfois agrémenté par un mélange de diverses fibres naturelles pour plus d'effets. L'OBOM servait de cache-sexe attaché au niveau des reins et protégeait l'entre-jambes. Les pygmées étaient les premiers à l'utiliser. Ce costume est resté l'apanage des patriarches pour des cérémonies ou rites traditionnels.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
40b0e5d2-7023-47bb-a924-7257b57765d6	antes para  coseguir tela para aser la falda sacaban cortesa de un arbol llamado golpeaban alrededoe de palo para que pueda estirar la cortesa  despues cosinan por barrios minutos  despues ponen a secar al aire libre en sol. para conseguir piolas sacaban de shambira la fibra eso se lavan y cosinan para que quite el color de la fibra despues ponen a secar por barrios dia en sol ,despues se ilavan con las manos dando bueltas puesto en la pierna , despues asen piolas para utilisar pasa cuerpo eso cubrian su cuerpo puesto en crus. para la piola de la corea eso sacavan del algodon ilavan dando bueltas con un palito y con sus dedos dando bueltas asi octenian las piolas para la corea que usan los hombres. Arbol de balsa acian los aretes de 24 milimetro en circulo. de befuco acian las coronas con sus tecnicas antiguas dando cruses   y las plumas eran de guacamayo que fueron casados por ellos en la selva amazonica de ecuador. las lanzas hacian de chontaduro tumbavan al arbol de chontaduro para  partir en mitad y media cada troso para hacer  troseavan con machete de metal  luego ivan afilando las puntas y los ganchos  con chuchillos	t	2d585863-97ad-4543-86cf-d83bcc67e635	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
ba421eda-df16-4ab3-ba13-a5fa3b3ba4c8	elavoraban faldas sacado de cortesa de un arbol. las mujesres usaban faldas para cubrir su parte intimo del cuerpo. y las fibras de shambira ilavan para hacer las piolas para cubrir su cuerpo   ,hombres y mujures usaban. el hilo de algodon usaban para hacer la corea eso amaravan los hombres en punta de testiculo , de las fibras de shambira elavoraban para cubrirse su cuerpo , y la corona acian de cortesa de befuco y con plumas de guacamayo. las lanza fabricaban  de chontaduro de 4.10mtros de lago y de grosor de 35 setimetro. de la balsa hacian los Aretes tanto para hombres y mujeres. y collares acian de fibras de shambiras a mano realisaban las collares.	t	2d585863-97ad-4543-86cf-d83bcc67e635	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
d2f5fcf4-2f64-45ad-b16f-13dcc6565759	nuestro antes pasados nunca utilisaron tinte arteficiles. para conseguir buscaban flores, plantas,semillas, raises de plantas y la cortesa de un arbol. esos eran material prima para  extraer el color que necesitaban. el proceso acian , raspaban la cortesa del arbol  y  las escamas que salia  usaban , despues hervir en una olla  y lo pone los hilos de shambira  para teñir  asen el mismo proceso para teñir todos los colores. despues se mesclan para cambiar del color  y lugo ponen a secar al aire libre en sol. algunas personas??? hoy en dia an dejado de utilisar tintes naturales. por falta de conosimiento de sus atepasados. pero usan tiente arteficiales   que son facil de usar 	t	2d585863-97ad-4543-86cf-d83bcc67e635	672e0f91-1a66-4a05-a614-076179532d30	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
63dd7ca4-7769-43fb-8f2a-a94e76b9f439	En generacion en generacion la forma de vestir y estido de vida. herencia de nuestro antepasados para que no desaparesca nuestra cultura viva .la ilustracion de nuestra vestimenta tradicional reconociendo nuestro contumbres y tradicion. nuestro vestimenta tiene un sinificado, que nosotros somo pueblos que defendemos nuestro territorio. para nuestra generacion de presente por venir y futuro. cada año selebramos dia de creacion de comunidad. para identificar nuestra cultura viva que en generacion en generacion mentenemos nuestra cultura , constumbres y estilo de vida como tradicion nuestra como waorani	t	2d585863-97ad-4543-86cf-d83bcc67e635	84f55ba3-2a76-4bbd-bf50-481a0d9884b2	2023-03-24 18:03:30.102	2023-03-24 18:03:30.102
ba6e7a71-deae-44f2-bbb9-75ec49ed74b9	nuestro antes pasados siempre utilisaban. hojas de una plata. y falta elaborada de ñashama y para los hombres piola de algodon que utilisaban para amarar el testiculo ,en la sintura como corea ,todo evento como en danza cultural  , reunios y en eventos de matrimonio llevavan para identificar quien es la persona mas inportante . la pareja que usava todo  es la mas respetada por tribu  , la mujer bien vestida fue la  mujer del hombre cazador. que usaba falta de y la con plumas de guacamayo y resto del  vestimenta como , pasa cuerpo ,brazalete ,collar , arete. las mujeres utilisaban falta que cubria asta rodilla  y pasa cuerpo que utilisaban piolas de shambira puesto en una cruz  en su cuerpo. que se cubria al ceno alas mujeres ,y collar que utilisaban en el cuello anbos hombres y mujeres ,tambien la manillas y coronas. los honbres utilisan corona puesta las plumas por de tras y las mujeres corona puesto de pluma al frente  y asi conocian la diferencia. los hombre tambien utilisaban pasa cuerpo para cubrirse el cuerpo los hombre siempre utilisaban lanzas en enventos como reuniones ,noche cultural , en matrimonio  como seguridad del tribu	t	2d585863-97ad-4543-86cf-d83bcc67e635	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
668ddd9f-7935-4ec0-bbf6-42a1571f7e0c	Before, We made  fabrics and yarns by using cotton. Firstly, We spinned cotton by using the spinning jenny to make yarn. When we got the yarns, we made it to be strong and clean by using rice and coconut cover. When it was strong and clean, we weaved it to be fabrics by using back strap loom.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
6a6ccdd0-7ede-40b4-8e57-4db4a74d2d0a	The buildings which  I lived , it had a lot of floors per a house and it  built by cement, bricks, stones, nails, steels,woods and zinc roofs. But, the people who lived in this community used to build their building by bamboo, woods, leaves, raffias and ropes from trees. For the people who were really rich from this community, they used to use laterite stones for building's foundation.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	332d4983-ffae-4dac-876e-4d86743c1b25	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
11e3f6f4-5ecf-48eb-bf1f-f7c486ef02aa	Before (over hundred years),We made  fabrics and yarns by using cotton . Firstly, We spinned cotton ( move the wheel to go around front and behind to produce yarn from cotton) by using the spinning jenny ( the equipment that spinning cotton and building by bamboo or wood) to make yarn. When we got the yarns, we made it to be strong ( not to break easily when we are weaving and sewing) and clean ( to get  better quality of  cotton ) by using rice ( boiled rice with cotton together to be strong and hanging them to dry) and coconut cover ( taking out useless cotton powder when they were dry). When it was strong and clean ( good enough to weave) , we weaved ( we repeated a single yarn by crossing the yarns that  on the loom and  using wood to combine them) it to be fabrics by using back strap loom ( wrapping   the  strap loom  around the back).	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	2d40ba5b-d1e4-4eef-91ea-2b42813e1f3f	2023-03-24 18:03:30.186	2023-03-24 18:03:30.186
804499ad-c8fc-4aa9-b9f9-29e1921f7227	We used  woven cotton fabrics to make our clothes.For long dresses and blouses, we used needle and yarns to join four breadth fabrics by hands. After that, it became a clothe which had four seams  that front ,behind, left and right. For the longyi, we firstly joined the length of three long pieces' fabrics and we sew its breadth in to cylindrical shape. For sarong, we join two fabrics'breadth.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
7a642fed-1039-4dea-ae0b-93a7189ca6bc	Before buying dyes, we dyed the fabrics and clothes by using the  liquid of  plants or trees, leaves and flower. We chose them which had the colours that we wanted  and we boiled it. After boiling it, we mixed the yarns, fabrics and clothes with these liquid to get the colours that we want and need.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
e0f2e056-3500-4b72-8edc-30fb2cfe6541	Before (over hundred years when the period of the village leader’s father and grandmother ) buying dye ( artificial dyes ) , we dyed ( to create and put on beautiful colours ) the fabrics and clothes ( they are making from cotton woven ) by using the  liquid of  plants or trees ( slicing their scales or cutting their roots and boiled it in the pot with water) , leaves and  flower  ( we could make them to dry all if we want to dye later). We chose them (checking their leaves or flowers or scales or roots) which had the colours that we wanted (to get the brighter and different colours for our clothes) and we boiled it. After boiling it (when the water turn to the colour), we mixed the yarns, fabrics and clothes with these liquid to get the colours that we want and need.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	bb427bb5-16d6-45be-9219-af673da92879	2023-03-24 18:03:30.228	2023-03-24 18:03:30.228
1ce73527-a86e-450c-b8f9-4f22f0e9c7a4	Before, We adapted the shape and style of our clothes by generation to generation. The illustration of clothes  traditionally had meaning. It represented the things that related to Ta Lah Kone religion, Special events , Karen culture and traditional.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
e50a70b6-40d6-4bd9-bf4e-a6ea7a68da3a	We adapted the shape and style of our clothes by generation to generation (inherit from our ancestors and not to be disappearance). The illustration of clothes traditionally ( following to the ways of our society)  had meaning. It represented the things that related to Ta Lah Kone religion (the things or statues that we worship and honor), Special events (patterning the shapes of the items or ingredients what using in Wrist Tying Ceremony and Fire Festival ), Karen (the largest tribal minority in Myanmar) culture and traditional (the instruments and items using in Karen New Year that falls on the first day of Pyatho in December or January).	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	78b891ea-af71-46a0-9bae-484a2cac0335	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
256c433e-a134-47f4-b7f1-6df355541ebc	For the people who get married, they have to wear traditional outfits . It is different that long dress and sarong are for men and blouse and longyi for women. For the people who haven't married, both of boy and girl have to wear dress .We have to wear it everyday and everywhere but we can wear plain shirts when we plant on the farm.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
6b1923dc-d088-4cd3-b4ba-7a12da239893	For the people who get married ( become legal relationship with someone  as their husband and wife), they have to wear traditional outfits ( wearing two parts of clothe)  . It is different  that long dress ( the cloth is long and straight till under the knees) and sarong ( the piece of cloth warp at the waist) are for men and blouse and longyi (sew the cloth into a cylindrical shape and wearing at the waist) for women. For the people who are unmarried ( they are available and  have chance to choose and find their partner ), both of boy and girl  have to wear dress ( no sarong and longyi). We have to wear it everyday and everywhere ( not only in Gone Thar Phaung Village but also outside that the places not this village) ,but we can wear plane shirts( no stickers, words and lines) when we plant ( growing vegetables and plants)on the farm ( the places for planting on the  fields or on the hills).	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	23dabc22-e363-4d28-8be9-450ea93ac194	2023-03-24 18:03:30.286	2023-03-24 18:03:30.286
af982e1e-229f-4756-a033-6793e3bca535	Tous les matériaux étaient recueillis dans la forêt environnante. La toiture était construite à base de feuilles de raphia tissées sur des bambous appelés 'nattes', qu'on attachait au moyen d'une partie aiguille de bois sur une charpente faite à base d'arbustes avec du rotin. Les poteaux et les poutres étaient obtenus en cassant un arbre à l'aide de grosses pierres qu'on frappait le long du tronc après l'avoir abattu. La case était faite de demi mûrs également constitués de nattes. Le sol restait plat et nu. Toutes les jointures de la construction étaient faites par des attaches en rotin.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
7f766440-939e-452c-8ef9-2e471317e939	Pour construire l’ABA, on commençait par l’identification d’un site, généralement en hauteur et au centre du village ou devant la case du patriarche. Par la suite, les artisans prélevaient tous les matériaux nécessaires en forêt et les transportaient sur le site déjà aménagé. Une fois sur le site, les artisans plantaient les poteaux et les poutres ; puis ils construisaient la charpente avec du bois, tissaient les nattes, qui étaient par la suite disposées sur le toit de façon à se recouvrir, à la manière des tuiles. Enfin, ils recouvraient le long des demi mûrs des nattes pour les fermetures.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	0b40373e-963a-4ce7-8a7c-85b58c2eeb2b	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
3fd518f9-4957-468e-9a8f-f00f92500b25	La description formelle de l’ABA semble être le paradigme d’identification des peuples Béti en général et Bulu en particulier. Ces faciès architecturaux sont le reflet des matériaux particuliers que livre le milieu écologique. Les aspects variés que présentait l’ABA résultait aussi d'influences diverses où se mêlent l'héritage de la tradition, celui de la colonisation, et les effets de la proximité de la capitale, suivant les ressources des villageois. A l’origine, le style architectural de l’ABA venait de dôme des pygmées, qui étaient les tous premiers occupants de nos forêts.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	d0ddeff3-e631-438d-909f-ab7f9d05a7af	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
8082d463-00b6-48eb-b2df-1378a21957df	la différence est que nos logements étaient construits avec des murs de boue séchés enduits d'un crépis blanc, argile kaolinique provenant du marigot, complètement fermés avec des portes et fenêtres en bois, équipés de plusieurs lits étroits et une sorte d'étagère au-dessus du foyer qui sert en partie à ranger les marmites et en partie à fumer le gibier tué ; alors que l'ABA était construit à base de bois, écorces et feuilles de palmes de bambous qui sont couverts de paillassons faits des raphia, le tout est couvert de nattes tissées. Il n'a ni fenêtres, ni portes et construit en demi murs.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
970a6e4e-e793-460b-857d-adb52835fa39	Nos bâtiments communautaires anciens ABA étaient construits à la main exclusivement par les hommes. C'était des bâtiments faits à base de raphia, associés à d'autres matériaux comme le bois ou le rotin. Des poteaux, faits de jeunes troncs d’arbres sont enfoncés dans le sol sur le pourtour d'un rectangle. Les montants vont être reliés à leur sommet par trois troncs rectilignes qui serviront de poutres dont une sur chaque longueur du rectangle et la troisième, posée sur les deux poteaux les plus hauts, formera la faîtière. Cet ensemble va soutenir une charpente de bambou à deux pairs.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	1757aea7-7e07-4a79-85d0-92a92e27571a	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
e6c42079-9804-4fa2-8619-2198fb97a3c0	Los  materiales  recogían en la selva montañosas nativas,  para el techo usavan hechas de Pajadetoquilla partidas en mitad amarados sobre  en panbil con piolas resistentes recogidos rompiéndose  grande del bosque nativo, los postes para la pared están hechas con  tiras de panbil y amarados con piolas de befucos juntos con pajadetoquilla partidos en mitad. y el piso es de tierra pura estáva arreglada y nivelada en plano    por manos de hombres y mujeres	t	2d585863-97ad-4543-86cf-d83bcc67e635	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
dc4f0cdf-4027-4032-a030-328825d7aead	antes de construccion de casa tipica "waorani " buscan un lugar adecuado donde no haya peligro con los árboles grandes tampoco con inundaciones del río.  los arquitectos saben como ubicar sobre los viento fuertes y suaves de esa forma comienzan a parar los postes extraídos (sacar ,//poner algo fuera de donde estaba) del bosque materiales necesarios para la construcción primero ponen los postes y luego las vigas y las tigeras ,último van las hojas de ungurahua  y material para el techo 	t	2d585863-97ad-4543-86cf-d83bcc67e635	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
7dd114b1-1a83-4223-9874-b90a6ebd4562	La descripción real de construccion de casa tipica waorani"  ase siglos que an venido manteniendo como herencia de  tradicional cultural ase más de 60 años después de contacto con mundo occidental, an dejado en barrios lugares la construcción de casa tipica , usando nueva conocimiento an hecho en diferente construcción modelos a occidentales. originalmente la casa tipica proviene de nuestros antepasados tribus "huarani" tipo de estos modelos son únicos en la historia de nuestra cultura y tradiciones en tema de casa tipica	t	2d585863-97ad-4543-86cf-d83bcc67e635	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
0a86921f-8b2e-49fc-9e29-6664548d9876	La diferencia es que nuestros construcción de casa tipica eran construidas con materias primarios de bosque. construida con troncos de panbil vigas de árbol de cálida y la tijeras de panbil, amarados con techo de Paja de ungurahua  y las paredes son de panbil y Paja de ungurahua amarados con piolas de  befucos de alta resistencia por dentro hay docenas de amaca para dormir alado tienen leñas para candela que da calor en la noche y por tejado tienen sus lanzas cada docena por dueño, la casa en cubierta por hojas de ungurahua	t	2d585863-97ad-4543-86cf-d83bcc67e635	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
c42cfd16-bde3-4dd4-a834-36bae5118820	Construimos casa tipica waorani  con material  primarios del bosque. Los árboles y sus troncos  lo utilizamos para hacer las bases y las vigas. La protección contra el viento está hecha de panbil del bosque . Para la protección de los amarres utilizamos piolas. La Pajadetoquilla se utiliza para proteger de la lluvia. El techo también está hecho de materiales naturales. La pared es de Pajadetoquilla. Los hombres construyen y las mujeres ayudan con el suelo. y recoger material para concretar para proteccion de las lluvias y del sol para sombra	t	2d585863-97ad-4543-86cf-d83bcc67e635	faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
664d239b-de6d-4ea1-9907-63864d64ecf9	For roof, we used leaves and we could choose woods or bamboo or leaves to use for walls . We also only used woods and bamboo for floors. We found and collected the leaves in the forest with our friends before the sun rose . After that,  we waved it with raffia in to big rectangular leaves  by our hands . If we didn't have the leaves, we bought from other people. We cut down trees and bamboo for construction by using our own dates and method to get a good tree and to be sustainable. Raffia was maken by bamboo.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	61147bd9-7701-41da-bfc1-cf66b91ee029	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
b7114ce3-4961-4896-9d7b-22e719e8ac45	For roof, we used leaves (dipterocarpus tuberculatus dry leaves) and we could choose woods or bamboo or leaves to use for wall. We also used only woods and bamboo (making long cylindrical bamboo in to a slab or slicing the woods and bamboo in to long rectangle pieces by knife and saw) for floors. We found and collected the leaves (only in fall, winter and spring because the leaves were not dry in the raining season and it didn't fell down a lot under their trees) in the forest with our friends before the sun rose (we had to go and woke up earlier than other people because there was nothing and wouldn't get good leaves if we were late). After that, we waved it with raffia in to big rectangular leaves  by our hands. If we didn't have the leaves, we bought from other people. We cut down trees and bamboo for construction by using our own dates and method (moonless and after full moon are good times and we don't use this tree anymore if we hear the voice that like snack's whistle when the tree fall down on the ground) to get a good tree and to be sustainable. Raffia was maken by bamboo.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	172802c0-27ac-4224-a3a1-d02693572025	2023-03-24 18:03:30.651	2023-03-24 18:03:30.651
678b3745-a176-476f-8820-33ec8717f1b8	Before we built floors, walls and roofs, we had to build foundation , arranged and tied the poles first which shape and size we want .  For floors, we  laid down bamboo or woods on the poles . After that, we tied them with poles and  raffias or ropes from trees . For walls and rooms , we also  tied  leaves or bamboo or wood as we were tying floors. For roofs, we only tied leaves, riffa and pole together step by step.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	82191f49-87b3-4a56-896f-869a3e6ad49e	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
b2ee6a86-d6cd-43b8-86c7-dc6e7dc99622	Before we built floors, walls and roofs, we had to build foundation (digging the holes on the ground, put in bamboo or wood poles in there and we recovered the holes tightly with the grounds what we have digged), arranged and tied the poles first which shape and size we want. For floors, we  laid down bamboo or woods on the poles . After that, we tied them with poles and  raffias (sliced the bamboo till they were thin and soft) or ropes from trees ( we found and cut liana in the forest and near mountains or we sliced some tree's scale by knife and twisted them like a rope). For walls and rooms , we also  tied  leaves or bamboo or wood as we were tying floors. For roofs, we only tied leaves, riffa and pole together step by step.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	92b6b061-18f3-4b2a-abc0-916aee1e6e7b	2023-03-24 18:03:30.668	2023-03-24 18:03:30.668
fffe36d7-74f9-4917-8267-ec9eba9aeb6f	Before we constructed the building, we measured its shape  by using ancestor methods.We had different kinds of style and size in our community buildings because we could decide  which one we prefer and beautiful in our eyes. That's why our houses or building's style and size were not the same.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	b185bd11-bce0-4bfb-a4f2-5f6852e24b59	2023-03-24 18:03:30.686	2023-03-24 18:03:30.686
a8e1cf2c-be50-4520-929d-7598afbe398a	Before we constructed the building, we measured (using stick what marked by cubit before we have measuring tape) its shape  by using ancestor methods (for worship place has to have on eastern and southern. Letter has to have only western and northern and every the step of letter have to finish with odd numbers if we don't do and follow it , we will not be wealthy and bad things will be effect our business, health and households).We had different kinds of style and size in our community buildings because we could decide  which one we prefer and beautiful in our eyes. That's why our houses or building's style and size were not the same.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	e70e48bb-a391-4f47-a82e-fe829d1b98f5	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
30e87e1f-7cb6-4985-8f9f-7cd976c25b98	The buildings which  I lived , it had a lot of floors per a house and it  built by cement, bricks (digged the ground, mixed it with water and  put it in  the  shapes of rectangle cups . After that , arranged and dried them in the sunlight and baked them with fire), stones ( buying  gravel stone from the shops near the river and we buy lime stone from mining places ), nails, steels,woods and zinc roofs. But, the people who lived in this community used to build their building by bamboo, woods, leaves, raffias and ropes from trees. For the people who were really rich from this community, they used to use laterite stones  (bought from the people who could find it. They carved them by knife in to square and made the hole on the tope of square to put in the pole and to protect termites eating the poles) for building's foundation.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	5883cbba-b8ac-4fb7-96e6-aa318ee73d90	2023-03-24 18:03:30.71	2023-03-24 18:03:30.71
6f5c45d0-c994-4e56-8787-5190a3a6b6c1	Nowadays, people would like to stay in popular building. Even though the buildings which constructed by natural ways are not sustainable and as popular buildings, they make us healthier than it. That's why we still have the buildings that constructed by natural things and ways around our community. Sometimes, we also might be out of keeping because of following the present time. If all our Karen people can also maintain our things and follow the present day at the same time, it will be great.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	6e836e15-3511-4b5a-ac9d-ee26412f381f	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
89e6a3af-2edd-4442-85bc-dc6e28fd3975	Nowadays, people would like to stay in popular building (constructed by cement, concrete brick, stone, steel, and zinc roof). Even though the buildings which constructed by natural ways ( used the things that got from nature and constructed them by ancestor methods)  they are not sustainable as popular buildings, they make us healthier than (they maintain the temperature depend on the weather and there are no disadvantages, comfortable and peaceful because it are natural things) it.That's why we still have the buildings that constructed by natural things and ways around our community (not only in Gone Thar Phaung Village but also the villages that around in Kayin State even Thailand- Myanmar's border where Karen people who live in refugee camps). Sometimes, we also might be out of keeping because of following the present time. If all our Karen people can also maintain  our things that culture, tradition, costume and follow the present day at the same time, it will be great.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	397b540f-02b4-4973-abd4-b15c26dabbe4	2023-03-24 18:03:30.726	2023-03-24 18:03:30.726
b8525578-7a68-4ecb-8922-3c6d0e3ccc59	Servant aux personnes et aux biens, le peuple Bulu utilisait divers moyens de transport. Sur terre, le transport était essentiellement à pieds, à dos d'homme avec des hottes. Les hottes jouent un important rôle dans les travaux champêtres ; elles sont portées sur le dos. Sur l'eau, on a navigué sur des pirogues à rame pour se déplacer sur la voie maritime en forêt, pour pratiquer la pêche peu profonde et transporter des charges plus lourdes. Sur le plan astral, nos ancêtres utilisaient la téléportation spirituelle réservée aux initiés de la tradition.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	d8f63525-be32-4d33-a289-0d74454b8446	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
f5f82967-db12-4a47-ba33-5791366fe413	Les raisons de coût, de rapidité et de sécurité guidaient le choix des modes de transport qui étaient utilisé. Quelquefois, c'est la géographie, le climat et plus généralement l'environnement qui obligeaient les gens à utiliser un mode de transport plutôt qu'un autre. Le peuple Bulu se déplaçait le plus souvent soit à pieds, et à dos d'homme avec des hottes, soit en naviguant avec leurs pirogues, soit encore par téléportation spirituelle pour leurs travaux champêtres, récolter des essences ligneuses et non ligneuses, leur commerce ou participer à des évènements heureux ou malheureux.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
5ffd903e-f253-42af-bf87-5dda58489947	Le déplacement par voie terrestre s'effectuait à pied avec des hottes au dos, puis la traction animale est apparue. Il a pris son essor avec l'invention du moteur. Le transport maritime s’effectuait en pirogue à rame manuelle. Pour le transport par téléportation, il suffisait d'être en contact avec le détenteur du pouvoir spirituel traditionnel pour être téléporté vers l'endroit souhaité. En effet, tout le monde au village n'avait pas la capacité de se téléporter,  ou de téléporter des co-voyageurs. Seules quelques initiés maîtrisaient cette pratique, et étaient chargés de d'accompagner les autres.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	5c824c54-b625-41ba-800b-569a324d9330	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
8d8f39e1-b6f8-424c-abd8-0192e99e20c4	Pour le transport terrestre, on utilisait les pieds, les bras, les épaules et le dos. Les épaules supportaient la grande partie de la charge, mais aussi le dos qui en assurait le support. Pour le transport maritime, on utilisait les bras, le dos et les pieds. Pour la téléportation, les voyageurs invoquaient les esprits des ancêtres et de la forêt. En tout état de cause, il était indispensable d’être endurants et de mettre tout le corps à contribution pour se déplacer. Pour faciliter les déplacements et faire face à l'extension de la demande, les réseaux de transport se sont modernisés et intensifiés.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	9276e06e-d1e1-4dac-a365-020cf2ee2ad4	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
d30d4f7e-faf1-4ce0-93d3-f47669a0ed32	Jusqu'à ce jour, la hotte est utilisée non seulement pour transporter les produits des champs, mais aussi des vêtements, volailles et petits enfants. La majorité des déplacements se faisaient à pieds. La voie maritime était le plus souvent utilisée pour la pêche et le transport des charges très lourdes. Par ailleurs, l'art de la téléportation n'est maitrisé à ce jour que par quelques rares personnes initiées à cette pratique traditionnelle. Seules les communautés Pygmées utilisent encore la téléportation ouvertement pour se déplacer sur de longues distances.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	04ec782f-1d50-44a9-a943-c94310cfd30f	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
2e930016-e6ad-4270-a971-33394570a566	Hace muchos años mis tatarabuelo y abuelos vivian alejado de los rios  vivian en las montañas , no tenia medio de transporte  como hoy en dia, solo hacian canoa hecho de cedro  como medio de transporte fluvial acuatica. Para ir de visitas iban a pie  a kilometros su cuerpo fue inportante como heramienta para largo viaje ,la canoa utilisaban para ir de pesca ,crusar al otro lado cuando el rio esta cresido o viaje largo de visita a familiares.	t	2d585863-97ad-4543-86cf-d83bcc67e635	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
dc5fa4fc-7405-4b8e-8003-88d3c2872805	 La canoa Utilizan para ir de pezca ,o salir a pasear por el rio , crusar cuando el agua esta cresido por fuerte lluvia, tambien para llevar carga semillas de platanos ,palos de yuca ,plantas de cafe ,cacao,maiz,material de construcion de casa tipica.Para viaje por montaña van caminando por que  no tienen medio de transporte van a pie dia a dia para llegar a su destino.	t	2d585863-97ad-4543-86cf-d83bcc67e635	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
6e66aad2-c32e-45b1-933a-aa32a1a9b392	Solo necesita ayuda de humano para poder mover , hay que saver palaquear para no chocarse con los palos que estan en rio . Se necesita  un remo o un palo delgado de 3 metros para mover la canoa. Poner en posicion de  un contra viento despues mover para atras al palo de 3 metros  para que la canoa pueda salir hacia adelante  y saver controlar para que no pueda virar la canoa.	t	2d585863-97ad-4543-86cf-d83bcc67e635	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
81fbce51-dc1d-4c1c-87a0-e0786674d445	Lo mas  utilisado son los brazos que hacen un trabajo duro para que la canoa pueda mover y salir a destino que el hombre necesite aveses el dolor es fuerte que realisamos el trabajo con la palanca. Para que no se dañe la canoa hay que cuidar  ,donde mas se utilisan es en salir a shacra ,pesca , paseo , hacer cruses al otro lado del rio. Y para viajes por montañas son las piernas humanas  que usan para caminar durante 12 horas para llegar asu destino.	t	2d585863-97ad-4543-86cf-d83bcc67e635	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
5d30a23a-05be-44d5-8916-6d166795e94b	Forma donde mis abuelos utilizaron como medio de transporte antiguo ase mas de  miles de  años . No ubo para ellos medio de transporte para terreno firme solo en fluvial acuatica. Para terreno usaban sus piernas para caminar a largo distancia  y para ir por rio lo utilisaban canoa  hecha de cedro para ir de pesca ,viaje de larga distancia. esos fueron que utilizaron mis abuelos en antiguos dias en  aquel tiempo. Hoy en dia utilizan medio de transporte publico como buses.taxi,hurbanos,bote	t	2d585863-97ad-4543-86cf-d83bcc67e635	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
10f5895a-20ae-4582-b541-94d02ad5f408	Before we did have a car, bus, bike, bicycle, plan and train for transportation, there were 4 kinds of transportation to use. They were a cart, raft and boat. Cart was made by wood. For boat, we make a tree into concave shape, also need paddle to control and raft was making by bamboo.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	0d33f7e9-a80a-4927-a7f0-c6be670b2f74	2023-03-24 18:03:30.998	2023-03-24 18:03:30.998
f7653dfc-4fab-41ab-a22d-b94259b7f017	Before we did have a car, bus, bike, bicycle, plan and train for transportation, there were 4 kinds of transportation to use. They were a cart, raft and boat. Cart was made by wood (first, we need to cut down the tree, make it into long rectangle  at least 10 feet and we cut down it in this middle again about 9 feet of 10 and make it into V shape. And also, we  made axle for the wheels and making all of them in to 90° convex shapes and combine them to be a circle. We also had to make the wood in to egg shape with a small hole in the middle, join all of the poles with it and to make the axle for rolling. Then, we used iron around the circle wheels to protect them from spreading into their original shape again.  At the end of V shape, we have to tie with a long wood and have to make the place with wood or bamboo in to rectangle with the fences for the passenger). For boat, we make a tree into concave shape, also need paddle to control and raft was making by bamboo (making the holes on the top and bottom of it, tie them with the rope).	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	4dde4b4e-7079-4603-a1db-e43bdf59d12b	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
20e8aa99-6108-441b-b45c-1d7e0d109a2f	We often used cart in land when we needed to go far, work and to carry heavy things in every season. And also, we used it for emergency cases. On the other hands, not only boat we use for taking people, carry things and to go finish in the river but also, we use raft to taking people and things including animals on water way as well when we did not have any bridge to go to other sides of the river.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	6d6a3915-4f87-49c0-9050-80351256976d	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
e779eb4f-4321-4dea-aec6-9032e9efc1b8	We often used cart (it has 2 wheels, one sit for driver, place for other people and things and pulling by the oxen) in land when we needed to go far (to travel or go to the event  with group, to export or exchange seasonal foods to other places or towns), work and to carry heavy things (rice, fire woods, leave, bamboos, woods, rocks and other things) in every season. And also, we used it for emergency cases (it took the patients, pageant women to the traditional doctors and we also used to carry our things and to leave from dangerous places during civil war or unstable situation). On the other hands, not only boat we use for taking people, carry things and to go finish in the river but also, we use raft to taking people and things including animals on water way as well when we did not have any bridge to go to other sides of the river.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	6398d8fd-e173-4751-ab95-7e03ba3ee868	2023-03-24 18:03:31.023	2023-03-24 18:03:31.023
65aa080a-ca54-4252-a30d-6859c86a9f20	Cart has two wheels that pulling by 2 oxen that can go 6 miles an hour, it can carry 5 to 10 people at the same time and also can carry things around 2 tones per time.   For boat. For the raft can go by following the flow of river for 1 hour around 6 miles but if come back to opposite side, it even took only 2 miles per hour. The cart needed two oxen to work. We need paddle for boat to control, turn on left, right and turn around as well. small and long bamboo and it’s for raft to work in the river.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	243ebac3-bd83-4a4a-b9ee-41b90e550d37	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
b1540108-3cce-48bb-b735-f7dd769969da	Cart has two wheels that pulling by 2 oxen that can go 6 miles an hour, it can carry 5 to 10 people at the same time and also can carry things around 2 tones per time.   For boat (one sit for rower in the backside and the passenger had to sit on the middle and front sides. And also, it can carry 4 to 7 people depend on boat side it carries around 1 tone). For the raft can go by following the flow of river for 1 hour around 6 miles but if come back to opposite side, it even took only 2 miles per hour. The cart needed two oxen to work (have to beat these animals by stick to make the animal to run fast and 2 ropes for controlling the oxen to turn left, right, stop for the arrangement). We need paddle (have to make it into flat on the bottom and top must be as handle) for boat to control, turn on left, right and turn around as well. small and long bamboo (has to make it smoothly and around 10 feet tall) and it’s for raft to work in the river.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	f69b17dd-545d-436c-a1eb-6355fdaf3ffb	2023-03-24 18:03:31.041	2023-03-24 18:03:31.041
bd9206f2-e7a3-4913-9704-e0023a4ab174	The driver must sit in front of the place that passengers or things, holding two ropes and a stick for controlling oxen and cart and also need to shout loudly for the oxen. For boat, the rower needs to sit on the back side of the boat and he or she has to use hands. For raft, the controller could stay every side or conner by using hands and he or she have to go around on the raft to be stable by floating on the water way.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	9c9b35a8-982d-47cd-89df-9f34e687e4fc	2023-03-24 18:03:31.047	2023-03-24 18:03:31.047
01111c49-c443-4268-982a-e917737168ab	Nowadays, we rarely see people using the cart.  Cart is important for human being because people need to use it every season and every situation.  Cart can modify by people and they can design whatever they want. Boat and raft are useful too on the water way. All of those can take people and heavy things without using petrol but nowadays, we still see and use the raft and boat for the transportation that we use on the water.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	86628d1e-cff0-4a7a-8e36-d19b47358e92	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
71e380e3-7291-4a14-8b4b-98194a1b7f3e	Parmi les instruments de musique traditionnels chez les Bulu, on y retrouve le Mvet qui est joué par un initié et d'autres instruments telles que : le djimassa, l’ekalé, le makoné, le engang, le koué, le N’teuh, le mbaya, le kalangou, le djang, l’ambassibé, etc., qui tirent leurs sources des chansons et des rythmes et qui sont joués pour accompagner les danseurs et danseuses. Seulement, la révolution numérique et le développement sans cesse croissant des technologies font que ces instruments sont de moins en moins sollicités et ont simplement laissé la place aux nouveaux appareils.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
370b83e3-1afc-41f8-95da-591a749c78b5	Chez nous, la qualité du son est déterminée par la fabrication et les matériaux utilisés et la conception d’un instrument musical varie d’un groupement à un autre. Le plus souvent, les artisans Bulu utilisent les matériaux de la forêt comme : le bois, le bambou, le rotin, les calebasses, la peau des bêtes sauvages. Le Mvet, le Nkuu, chaque instrument étant une œuvre d’art unique, les clients passaient généralement leurs commandes auprès des artisans à l’avance et en fonction d’événements festifs, thérapeutiques ou encore rituels.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	5df3ee26-a777-4716-b201-e93ccd7fa64a	2023-03-24 18:03:31.117	2023-03-24 18:03:31.117
b6129fb8-83d8-4f03-9516-198eeeb4d5d7	Les artisans assurent en général tous les stades de la fabrication d'instruments de musique traditionnelle ; de la collecte des matériaux de base, en passant par leur transformation, et leur réparation ou prestation de services, à leur commercialisation. Leurs œuvres sont souvent réalisés soit entièrement à la main, soit à l'aide d'outils à main ou même de moyens mécaniques, avec des produits de base prélevés en forêt. Les artisans assurent aussi le côté esthétique des produits finis. La nature spéciale des instruments de musique traditionnelle se fonde sur leurs caractères distinctifs.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	8a2f711b-8654-44aa-b9e8-527b1e2fe9b5	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
42211632-042d-4217-95c0-cd8d9fb31d7a	La musique traditionnelle a déjà une mauvaise réputation. La musique traditionnelle semble perdre de l’importance avec le temps. Elle se caractérise par son profond ancrage à l’oralité et son contexte populaire. Dans la pratique, les musiques traditionnelles qui accompagnent généralement les danses s’exécutent lors de fêtes, de cérémonies et autres rituels. Les gens se retrouvent, chantent et dansent. Ce sont des moments d’une grande importance qui participent à la transmission du savoir ancestral. Le maître de séance a une grande maîtrise des us et coutumes de la tradition.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
d9c9378f-2482-4d31-8c0e-51d037af088e	Malgré cette présentation un peu alarmiste, notons néanmoins qu’il y a encore quelques artistes musiciens ou groupes qui essayent de préserver ces richesses culturelles et de rattraper les bonnes pratiques et l'utilisation des instruments de musique traditionnels Bulu. Certains se soucient encore de ne pas diluer leurs créations artistiques.  Aussi, précisons qu’il n’existe véritablement pas de festival consacré exclusivement à la musique traditionnelle au Cameroun. Généralement, c’est dans les festivals communautaires que l’on découvre souvent certains de nos instruments et musiques traditionnelles. Leur variété constitue un riche patrimoine culturel qui devrait être préservé et valorisé.	t	a016b260-36f6-4535-b20b-ea7af618ffc3	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
03c67dcc-1526-4e7f-a909-718d9dbf8e09	No hay diferencia en nuestra cultura sobre instrumentos musicales , como hay  solo 2 instrumentos llamados flauta de caña de huadugua  para hacer sonar, el hombre deve soplar .y otro en nuestra idioma llamsmos (ñanca) consiguen de un arbol  eso ban amarados en tobillos al mover pierna se suena  ,esos son  instrumentos unicos  que utilisaron y hoy en dia utilisan los nietos en esta tercera  generacion	t	2d585863-97ad-4543-86cf-d83bcc67e635	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
fcc72bc5-4785-4517-9a23-6715cd534793	 El material se encuentra en la selva  en las orillas del rio o quebradas rios pequeños , buscan las personas que  tienen conosimiento del material. Y hay  tres tipos de material y solo una es material para hacer instrumento musical llamada flauta  y( ñanca ) que tambien acompaña eso encuentran en arbol grandes en la selva	t	2d585863-97ad-4543-86cf-d83bcc67e635	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
e6fb7d53-a7a1-40a9-bf68-6159b97dd59c	Primero dejan cortando por 3 dias para que el material se seque bien  ,despues que este bien seco cortan asu medida. Personas mayores y jovenes  del tribu  cada uno se lo hacen. Se lo elaboran a mano con un cuchillo o machetes bien afiladas cortando en medidas justas. Para que el sonido sea mejor . Al soplar ala flauta   de esa forma estan preparados para los eventos en lugares festivales	t	2d585863-97ad-4543-86cf-d83bcc67e635	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
401d7742-f718-4188-984d-da6be9df96b1	Los instrumentos son utilisados en eventos  grandes y pequeños como , presentacion de danza , ceremonia del bienvenida , eventos de casamiento de pareja ,fiestas de yuca , asambleas del pueblos ,visitas de familiares ,  participacion en ciudades como desfildes. Y dia de nacionalidades . De esa forma se mantienen los instrumentos	t	2d585863-97ad-4543-86cf-d83bcc67e635	66f2f1a2-b204-4ca7-8903-afb8e314e86d	2023-03-24 18:03:31.225	2023-03-24 18:03:31.225
eebf640c-d3a8-450d-9cfe-405cfce85daa	Instrumento musical de pueblo waorani. Llamado Oña y Yanca, flauta y sonido en tobillo. Estos son los unicos que tiene como instrumento musical el pueblo wao. En generacion lo an matenido estos instrumentos. Hoy en dia algunos se an olvidados tanto jovenes y mayores   con contacto con el  mundo occidental , algunos jovenes utilisan sonidos de otros instrumento de otros tribus como jente de afuera  de la ciudad	t	2d585863-97ad-4543-86cf-d83bcc67e635	5bd68116-d7b0-4c2e-a355-b214fe8288eb	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
343c5d84-6c4d-4385-b112-42eea3766fcb	There are 4 different types of Ta Lar Kone traditional musical instruments. They are Pot drum, Buffalo horn, Cymbal and Gong Pot drum is the main musical instrument that has chirpy song and people need to wear on shoulder with rope.  It has 1 to 8 feet tall and 1 feet round afterbirth by measurement.  And also, shapes look like sour glass. Pot drum can produce good song for making people for enthusiastic and can use it in any community activity: dancing, singing during festival. Buffalo horn has sweet output voice that need to gig in the middle of horn and right hand need to cover in the bottom and left hand need to close and open the top to the horn for make better song. horn is for unity power. Gong has only one song that need to beat with stick that need to type with the cloth on the top it. But it uses for every country all over the world Gong, and cymbal stand for the bright lights. Cymbal has 2 sides for left-hand play and right-hand play for playing together like: clapping hand. And also, it is noises material among of Ta Lar Kone musical instruments. Usually does not use it by single item. Most of time, pair with Pot drum. Gong is for gathering, horn is for unity power . That’s all materials can be using at the same time when doing ceremony. Every ceremony opening song with   buffalo song, Then, 3 times with Gong song, after that start together with Pot drum, Cymbal as the same time.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
cec8014f-d25a-4539-bc20-968071bfcd63	Many years ago, the musical instruments materials. Ta Lar Kone people get the horn and lather from died-animals.  Need to cut down the tree finding vines from the forest as well. To get the copper for building the Gog and Cymbal for the instruments, need to dig the mountain that have copper. After get the copper, firstly need to give a heat for copper until become liquid. While doing that process need to dig small place and making in smooth and encase on it. When the copper getting hot and become liquid, coulis to the place that have dig smoothly with cover, keep it dry then start chisel on it with hummer.   In real life of Ta Lar Kone people, difficult to get material. They need to find of the died body of animal that have horn as buffalo and big animal to get the leather for Pot drum by themselves or going to other village for exchange with other items to get buffalo horn and the leather with villager who are not vegetarian. they need to exchange it with their seasonal fruit. And also need to find copper in the mountain for build the Gog and Cymbal for the instruments. However, if they could not find it, they might need to go around to other villages for exchange their seasonal fruit to get a material.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
c80ff1d9-914f-40c7-8325-0e616987b1ee	Usually, Ta Lar Kone people make their musical instruments by themselves. Firstly, they find the material by each item and combine to one. To build the Pot Drum, the need to cutdown the tree, after that, make a hole. Cut off the wood bottom to become smaller like cup shape then keep it under of the sun shine. At the same time, need to boil the lather for an hour and take off the depilatory on the lather. When the wood and leather are getting dry, start cutting the lather to become the cycle shape and make a small hole at the side of the cycle shape of the lather. Then start cover the top of the wood with the leather and tied with the ropes tightly side by side round conner and add with long rope to carry it easy. After finished the process, it's become the Pot Drum and we can start playing it. For the buffalo horn, need to boil it for hours and take of meat inside of the horn. After that, start cut off the bottom of the horn straightly and small cut off the top of the horn. the Gog and Cymbal are same items to build and need to burn and give a heat to the copper rock until become liquid. Put it on the ground and start make it with hummer to become flat shape of it items. Both of its items are similar cycle shape and another small shape on the middle but Gog has fence at the conner. The different is cymbal has 2 sides; lift side and right side. They make a small hole on the middle of cymbals. And also, make 2 holes on the top of the Gog as well. Gog need to play with a stick and cymbal can play by clapping it.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	0baac6ed-e780-4cc1-a5cd-8ced30f736e5	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
16bd4cdf-5279-4dcc-b778-a85947777522	Ta Lar Kone people using those items during festival but it has meaning to play in different times. And also, they can play it at the same time when making the harvest festival. Then, start playing horn and 3 times for Gog, 3 times for cymbal than start play Pot Drum at the same. After they have start paly all material, Ta Lar Kone people are standing on the plant of the rice with craw of people together with singing a song. That time is a month of the January in every year. And other times, the play it differently and different situation. They play the horn to start planting of the rice on top of mountain. It means, the lucking will carry it to green plants and more fruits for that year. Gong is for unity power. It’s mean need to work together and same goal of their life. Every time when Ta lar Kone people hear the song of the Gong, they understand it that need to come back to their village for participation on the activity. like: village meeting, funerary, building some things. Pot Drum and cymbal means to support people mind to be happy and active on each activity.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
e4beb5c2-2be4-42f0-b8b1-77522ce00566	In my mind Ta Lar Kone people have six musical instruments.  But they want to confirm 4 items only. Ta Lar Kone traditional musical instrument are likely with other ethnic group from Myanmar. Pot Drum is same with Shan ethnic group, Gong and Cymbal are using in every ethnic group. But especially, Ta Lar Kone people have difference meaning on it and playing not same among of another ethnic group in Myanmar. Ta Lar Kone people are stay to hush up in the community. Most of time, the pray and take meditation. They do not like to play music and singing like other people. Most of people in Myanmar said that “you are lucky people if you have seen Ta lar Kone people sing when they are doing activity in their village”. It’s mean nobody know where the Ta Lar Kone people is living and the date of their festival.	t	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
\.


--
-- TOC entry 3472 (class 0 OID 16578)
-- Dependencies: 227
-- Data for Name: Language; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Language" (id, name, code, "createdAt", "updatedAt") FROM stdin;
6f458c4d-df13-4235-b3c2-1d9fc9df7e34	English	en	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
a016b260-36f6-4535-b20b-ea7af618ffc3	French	fr	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
2d585863-97ad-4543-86cf-d83bcc67e635	Spanish	es	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
65ac9888-fd45-4733-85b2-9deafe17b16c	German	de	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
9ee1d750-5cbe-4337-81d6-35d5061e8dad	Dutch	nl	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3b46ee45-9d98-4cd6-acf2-c7e387f81c6c	Arabic	ar	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
fa56e8c1-4b00-4270-a0eb-f34158c705ce	Afar	aa	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
5fa3d464-a397-40d5-8ea9-b95cc8d643b9	Abkhazian	ab	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
a34a0c09-5513-4031-a961-4faac84f5947	Afrikaans	af	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e04f5e72-7ada-4883-8e7f-c51a963e690c	Amharic	am	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
c5ce4379-799d-442a-bd3c-f8f264b4adce	Assamese	as	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
ac32a897-dc3d-4677-bce3-7f5092693722	Aymara	ay	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
cbb6ef83-6a1a-4572-afff-6de4d73bd0e3	Azerbaijani	az	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
887d637f-6e61-49a0-b20f-bfb0931efcc9	Bashkir	ba	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
8d524520-276f-49de-8e37-976294ee54b1	Belarusian	be	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
b0a4be4e-35f5-4348-b713-4709f7e03036	Bulgarian	bg	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
6c29c8dd-381e-49d4-aadc-33b0bd6010c3	Bihari	bh	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
5ce97f6a-99f2-4732-8631-17924b12d252	Bislama	bi	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
2f857505-380a-40ce-b76b-d2610ccf545d	Bengali/Bangla	bn	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
965a18e7-be69-4266-b047-6e42226f1acc	Tibetan	bo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
5744cb8b-1685-4374-a2c4-e56c68c66407	Breton	br	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
0f08d614-c707-4735-9138-c28bdaaff0a3	Catalan	ca	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
154816eb-0acb-49cb-b9d6-18c7c6de1088	Corsican	co	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
06c582d0-ce51-426b-95cb-b8ac7e22524d	Czech	cs	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3d49a839-1465-4975-81a1-a8d0a55b2bfb	Welsh	cy	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
441899ed-0771-443e-9b76-5783e2de4345	Danish	da	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
83af3706-56a5-48ca-9827-e28db259c1f5	Bhutani	dz	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
bec3653b-afde-456a-94ad-51f544616816	Greek	el	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
7c478854-37a1-482f-afc7-4daafd3b8d67	Esperanto	eo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
0ea100ee-6d11-43ac-8150-f7851a6a571f	Estonian	et	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
de548292-0ff1-4b72-8ac5-adae77f4d3ce	Basque	eu	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
abb73044-9168-4931-935a-265c2564be2a	Persian	fa	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
31f0df65-1ae6-4f90-912f-e63f4835bdba	Finnish	fi	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
118f72ce-9ddc-4660-8e74-4019ec845b54	Fiji	fj	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
ca822326-9c6c-4ac4-a5ea-ea72d92ad76d	Faeroese	fo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
8ff51220-f371-4236-90c4-73317cb7486c	Frisian	fy	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3060b5ce-2c04-4f45-b582-094e1cc1d16f	Irish	ga	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
10715bd7-6155-4a5b-ad0a-cca84760270a	Scots/Gaelic	gd	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
0b07e883-7ba6-47ff-8be7-38b2ec61fcfd	Galician	gl	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
afb1a6d9-2031-47c1-bab0-1befcd1692be	Guarani	gn	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
b1dad1ca-fb3e-469e-83bb-1a2682c78b5b	Gujarati	gu	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
7ce77d63-ab62-4ac2-a166-90617e0f1599	Hausa	ha	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
8ebee9b6-b487-4830-af29-c21a17769df1	Hindi	hi	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
8ba2e9e5-ef92-4e07-b3b7-557afc936102	Croatian	hr	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
1681c69b-9f2b-4c82-be54-9758b6f1a408	Hungarian	hu	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
8b687401-6907-441c-a722-4f2343eabbc8	Armenian	hy	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
b72bc5b0-169b-49fa-a428-4917937535d6	Interlingua	ia	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
aed0dc25-6059-401a-baef-3094c0f669c0	Interlingue	ie	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
53dd72d5-a3b8-407e-8907-631c6271cac8	Inupiak	ik	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
98f8224f-6c41-420f-813a-35a3ccb78963	Indonesian	in	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
4318cce3-4522-49ac-ad4b-1d64a437847f	Icelandic	is	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
2b673211-1006-479e-8bc4-bbc6f606a6da	Italian	it	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e5270fcb-ab85-40fc-b189-c1ac63770e57	Hebrew	iw	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3702e41f-20c3-423c-9549-2cac7abda3d3	Japanese	ja	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
fb10474e-d459-4bc0-82be-5a51210dba9c	Yiddish	ji	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
1c51c1fb-3f92-4580-a19c-80352afceaca	Javanese	jw	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
191ab9e8-bba4-49fb-a71e-4be1ebcef01e	Georgian	ka	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
491b8bc8-fc0d-4d41-94f5-ca1ce75c692c	Kazakh	kk	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
d050ceee-a228-43c7-9823-33d22124ae4f	Greenlandic	kl	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
b78352a9-8d3f-4839-b342-96dba8cd6b83	Cambodian	km	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e233f8a8-a095-435e-ad0b-98ba1110bb5c	Kannada	kn	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
5189e8c4-6cf9-469e-a921-ae484ef70119	Korean	ko	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
880d96d8-c69e-4d93-a1b2-cf7f3cb46fa4	Kashmiri	ks	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
edc74dc5-0b4b-4b71-a3e2-e3acf52a2276	Kurdish	ku	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
13dc5853-cada-40fc-9f4f-b222ad281748	Kirghiz	ky	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
a929eda4-efb3-4c22-8e85-eda62f375279	Latin	la	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
13e5da5d-a06d-466b-a740-e605df6390bf	Lingala	ln	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
9e350b33-4075-491f-853f-020ffe76d335	Laothian	lo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3eef7141-489e-41b8-9573-0c168d42d48c	Lithuanian	lt	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
7b295a53-82c6-4ddb-ac88-5ffde2cb8b1c	Latvian/Lettish	lv	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
249bf25b-acbe-4ba8-bee0-44a4ae531bd9	Malagasy	mg	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
56d4af6c-b692-43b1-8928-0135bee25a74	Maori	mi	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
9d084f8f-8137-4526-afde-325111aed85b	Macedonian	mk	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
6339b591-2e3b-4c5c-b09d-a6131e4a4faf	Malayalam	ml	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
df20fdee-dbfc-475c-8aab-324876fb67d6	Mongolian	mn	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
dd17e07c-2fe2-4513-b01c-8a0c7af7c2e6	Moldavian	mo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
9d1f60d9-aefb-4795-9089-73fb55fc79b8	Marathi	mr	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
c9cb85a1-aff0-4b41-8c20-37cfd4eb606f	Malay	ms	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e88b552a-7e81-42d3-ad8c-6111eeeeee7f	Maltese	mt	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
c94532a6-7dc8-4998-a550-34ba29c5dda0	Burmese	my	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3f1e776d-376c-40e6-9864-7caddd34c332	Nauru	na	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
a304f192-96cb-45da-b08c-6f07d1e6af5d	Nepali	ne	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3ac4b2ad-38e3-47fc-85d2-d5c9c4c5e906	Norwegian	no	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
10167af7-7c3d-4a22-bc1f-ec8313518afc	Occitan	oc	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
23cbadb6-db51-435d-b773-4849e2e1e5d9	(Afan)/Oromoor/Oriya	om	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
6924bd66-fde0-4161-a371-8b47720f5a5a	Punjabi	pa	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
f6f7ec80-9f85-4f10-b05d-d5aac75cfd31	Polish	pl	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
99923e72-ef54-451b-9fca-a6786e1506c7	Pashto/Pushto	ps	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
0a8c7091-66ca-4a6d-ab9e-efa4ee5c9767	Portuguese	pt	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
4eb6a60c-d5ca-42a7-b7f5-8222a613627c	Quechua	qu	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
d0bc5c51-bc56-4b44-b4bc-32a640327853	Rhaeto-Romance	rm	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e835b16e-e9bd-4031-a936-2038e2b859ae	Kirundi	rn	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
61a637b0-70f9-4a93-b42c-ac7c1c9f594b	Romanian	ro	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
943450df-59c5-4521-b1c4-8ea8a4b4760e	Russian	ru	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
d988940d-1919-4082-a5c5-05140f26c6bb	Kinyarwanda	rw	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
31fabac0-b857-4e39-93d3-6a49b367bcbb	Sanskrit	sa	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
1864d10f-bc49-4e07-9b21-b849aa73fa0c	Sindhi	sd	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
2c8bf418-e60f-4edd-a7cd-b680624b37e8	Sangro	sg	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
d1236d61-d860-4d20-90bb-fa90bca33909	Serbo-Croatian	sh	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
2db02bdb-25c1-4be0-b1fc-0d59ee4a15a2	Singhalese	si	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
9ce3b40f-7f03-40cf-96a5-6210ae756be6	Slovak	sk	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
18b2e1b7-97ed-4927-bb0c-f869ada7714c	Slovenian	sl	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
259ae559-647a-465e-b92e-c169b7e655fe	Samoan	sm	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
a9cfb28c-f617-4972-b259-7317d41ee71a	Shona	sn	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
1ad311b8-3cb5-468f-a904-f61050091c44	Somali	so	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
cdb672a7-79de-4236-acb2-e89fcb6b24c0	Albanian	sq	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
79b80119-e4ea-4e55-8273-e79b9fef7b92	Serbian	sr	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
a5d70e28-5310-4ee8-ae30-a84b19c39650	Siswati	ss	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
001402c2-590b-47bb-a2ce-0c371a54e210	Sesotho	st	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
a6cc6868-2066-43c0-b520-9e816a86cae5	Sundanese	su	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
ee6c9124-e705-4967-8274-6b97d6f12d4c	Swedish	sv	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
deac5179-e713-49c2-b2c8-cfd9f8407767	Swahili	sw	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
c5035fde-e7a0-4113-8c03-33400cb47589	Tamil	ta	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
b17eba70-3db8-4d0b-95ee-aee077a6a791	Telugu	te	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
f5d87a9d-0151-4d51-aa7a-bca915a494d0	Tajik	tg	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
3b1e10a6-670a-4300-9341-ea4e78b338c4	Thai	th	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
55131028-3e73-4fd2-91de-fdef7d778a69	Tigrinya	ti	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
ba9bb82e-15c7-4f8b-bf83-ba4813555c6b	Turkmen	tk	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
282fdf4d-8e78-4ac2-98a8-4f4f408716d8	Tagalog	tl	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e9792504-39ce-411f-b192-0a8d09d9e70b	Setswana	tn	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
1cc808d4-2e33-4c05-93e0-8241d93134af	Tonga	to	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
786accc8-c314-4d71-b93e-9b05bd55ac90	Turkish	tr	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
f8300a0c-de51-44ba-897e-ea267bd7c1e7	Tsonga	ts	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
0ddf2ed7-0eda-4c08-bc80-e5d088a7b76d	Tatar	tt	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
7b8361fb-db4e-48ba-8e36-cd711922cab5	Twi	tw	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e8080019-0d89-4cf5-9580-16236aad1537	Ukrainian	uk	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
53a985e7-08e7-4dd7-950f-51d217928497	Urdu	ur	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
7c32f86d-a55f-4deb-964b-849f9c2b94a0	Uzbek	uz	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
ffa94495-c9f5-438e-9627-3b1c903ba245	Vietnamese	vi	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
7e53023b-32c9-4c58-b13c-d3f64b9cb150	Volapuk	vo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
1b59a136-104a-4d13-837e-5a356ded39eb	Wolof	wo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
e7ba6f98-4fd4-45eb-8daa-33db8d9718ff	Xhosa	xh	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
c5714f59-6b14-4829-a42a-0c117b3865e5	Yoruba	yo	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
ed5cbfdb-5a46-45ca-9697-680f20c75cf5	Chinese	zh	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
050ed1b6-717a-4ad1-9953-15c0ccf9d371	Zulu	zu	2023-03-24 18:03:29.245	2023-03-24 18:03:29.245
\.


--
-- TOC entry 3466 (class 0 OID 16469)
-- Dependencies: 221
-- Data for Name: Qualification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Qualification" (id, "answerId", "createdAt", "updatedAt") FROM stdin;
e9318ded-65b4-450c-a9a9-86c00d8977dd	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
bacf51c7-0ac5-4dde-9238-cc3905065f30	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
875a3d69-cf50-46c4-baa2-f97f9c3aff56	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
b5d3ec3e-a901-4d36-bba4-f9edf8b893c2	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
9b80ee06-73bd-487b-b00d-dcb8f5770e83	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
30370680-e3e0-4027-a133-9da0a570d3bd	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
d87ae8c9-78fe-48a6-947f-cf5957dbde56	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
4aefe4df-424e-43d7-a6a6-cf0fe22fd46d	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
e18e259c-4cd5-4f97-916b-de98d015f840	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
a796a1d9-a28e-4075-be58-d73cfc595990	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
e07f3e37-9b06-45fe-b03c-aca655cb5044	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
63a33144-1eef-43b7-9ade-e5d2401c8323	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
345f117e-b05a-4b5f-9f0f-bcc1d2459478	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
236e5a6b-979a-486c-b1b1-a158831128a1	52da8df5-b0d1-46fc-9e17-828723aaeb63	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
cdf71810-9352-4ff6-941e-84bfb65bade3	52da8df5-b0d1-46fc-9e17-828723aaeb63	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
79c313a0-fc09-4f00-900f-486c13e38a15	52da8df5-b0d1-46fc-9e17-828723aaeb63	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
3acdd354-7f17-486c-b93b-1b3ab51d12d2	52da8df5-b0d1-46fc-9e17-828723aaeb63	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
01dd73fb-15f2-40d4-9087-3e48011a49a2	52da8df5-b0d1-46fc-9e17-828723aaeb63	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
a2d00d52-4079-4470-baed-4352c951d514	e727b6c6-b90d-42a9-887b-35106ace7898	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
ba7a38b1-87d7-4630-b4a5-4ecd54e2eb95	e727b6c6-b90d-42a9-887b-35106ace7898	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
50ba3094-5ad4-497b-b991-4f08f9600868	e727b6c6-b90d-42a9-887b-35106ace7898	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
3541cf6a-09d4-44d5-bb56-e2731089543a	e727b6c6-b90d-42a9-887b-35106ace7898	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
d8cd15ae-5182-4de1-a1d1-3cd284e79bb8	e727b6c6-b90d-42a9-887b-35106ace7898	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
0a6f6e18-6ad9-4ac1-a287-fd4021a98fde	3c884f25-df39-4f76-888d-36120a7cf6fe	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
af5f451f-ac97-41f9-8b52-ac0260e0508c	3c884f25-df39-4f76-888d-36120a7cf6fe	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
4757f1a8-f2c6-437a-a2c6-8f0096e8dce3	3c884f25-df39-4f76-888d-36120a7cf6fe	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
18a700f5-178b-4937-8ff7-986cf7b72a94	3c884f25-df39-4f76-888d-36120a7cf6fe	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
0fc26184-d1fe-400c-92f4-38b942c9e307	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
a27aa165-4100-4eff-bd82-065b35e067cc	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
34440c7f-aac6-4213-aedc-d3ddf246d20d	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
48c123e9-62d4-418e-9fe5-78a07cb13340	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
2acf241b-2eef-451d-85a6-66e7b56e1f28	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
e8dfd2ca-1e5e-434b-918d-54249be362c6	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
53ee7737-12c3-4f11-bd01-9361440be094	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
79704410-5f9f-48fe-8fab-451d134969a4	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
122139f9-4b22-41ab-b876-95530c5bd3d7	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
96e65b36-f76c-4235-8155-c081c0f5c2df	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
2500c1c7-d308-4a79-872a-6cdeb5611f79	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
552f282c-3a3f-4cb2-a6c0-76f6a8f263b1	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
d0caca45-2257-4436-bcb2-8684d4319f31	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
5ec6ea5f-f11d-478f-a6b4-171d660232e0	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
2d2646c8-a29a-417b-bf34-e63197a598c5	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
022369d3-c99f-441d-b645-d2410d36980f	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
eebfcd25-022e-4134-829e-54d1414031a3	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
46a3e2e8-b0d8-4dfd-86fd-258caf910704	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
25b97b26-9323-4f23-9cba-63d18f0abaa4	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
3666f899-c9da-476f-aae9-5f9684d97ac3	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
3ceedbd8-7e9c-4c12-9ac2-5a6b0be5bfba	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
5f4ac6cd-b384-4a99-9147-5cbdac4c90fb	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
dc63aa84-bfbf-4b18-911e-bf05363797b8	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
1c30044a-506e-4a68-8e67-8dd8c074b132	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
c31de327-2530-40a5-b064-166e6141afe4	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
e2ffa93c-0f22-48a6-bd13-9399b42fab98	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
decd543f-c092-459a-943f-8f6fe7affe0a	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
bda8d43d-e9e4-42ca-ba31-8370fe5a3c08	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
86d05fb0-7f90-4f75-80d6-adf768002f6e	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
bf009def-8198-43dc-bb0e-8dd9eed7b4ec	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
ee38be13-8d38-4518-bed6-7b6ef433950d	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
54aa677a-141a-4cc8-a319-9c6a055205b2	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
21126f99-2eeb-403c-b961-664aeef468c7	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
5e93a604-8807-4120-b8bb-1a8c7adaf9bf	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
1fe276e5-87f6-42c5-9172-bd12876b978f	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
4d8d0ebd-5d12-4b2a-b1d0-46b8c6b9008e	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
fc82ecc3-cb9e-4f3e-a5d7-dae26c82ee99	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
d26d14bb-3220-4df3-b674-b981989f745f	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
d00d2287-ef1e-4bfc-a83d-89af3fce3eef	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
c31db8fa-1350-451a-94c5-c5f0a780eec9	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
cda63e32-de65-41a4-9daa-964d8425dba9	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
1766088c-5dec-4cbd-bc3c-a5406383b883	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
196ebf49-89c8-4b8c-9136-528bc200d667	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
6d4114ab-8e7d-4c76-9978-96d3cdde4cf4	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
4cd0ac5e-dc61-4a77-848c-8a5f2f3649e9	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
84ce4032-1b92-493c-890b-894a333afa83	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
6c312450-70b9-4290-a1e4-15b23c82142f	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
6f5aea71-2a32-43d7-9dca-074cf725462c	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
1cbd0da6-dae2-4965-95c4-55b041d31a32	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
9bbe557b-546b-46bc-8518-9a40553084af	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
4f6f4d32-69e8-4c07-b46d-ec007ff52a3b	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
b02a7685-15bf-4283-9256-df859bf7a698	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
a9c38850-0912-4c78-b46d-d5c38c488171	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
6361346d-affe-4cfa-b5a8-898bc4532712	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
709e0011-5e5c-4dc2-92eb-65abdc0b1f72	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
13edfe2f-e99b-4146-96ca-50668935107d	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
034c0f4c-aac4-405a-8672-16ab3d28b506	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
da0b08bc-9ef9-4e9f-b533-11f41b418887	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
0fc2c665-ad60-454b-8871-b3801a46094c	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
57cfe6aa-8c8f-447e-b97e-d291138d8e9b	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
c909604e-33d5-4a60-869e-f02660582a07	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
6a015867-5a9e-4475-880e-7d36855321ef	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
4c5fa0f4-ff0a-4b37-be07-d779d11116cb	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
aebc5d95-c64a-4035-b0e9-4b146239a769	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
d7a5d41f-fcf9-4400-8182-2e26323ee7a1	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
a0b540c5-9680-43df-b929-6d74494d00fe	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
7337dd5d-20e3-4a3a-87cf-f5003ce51843	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
dadde0a6-15dd-4bcb-9809-1b6e2142e819	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
c9e28d03-59e4-4263-ab16-5cb9b4e084aa	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
07dddc41-ce38-4b29-bfe8-ddeecad95bd5	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
0cb55939-1e83-4a12-ae34-e22bad2acaad	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
5e219002-6253-4b6c-84bc-55dbeff64df9	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
e76c8363-29aa-40d6-a657-91dab4bfa65e	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
cc463ade-b8ba-4726-b062-ef5d1d855d51	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
299673ce-e4f0-4e45-af03-a5cda5ca2253	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
c4e4b70b-cdfd-421f-a9e5-b924d75bd90f	994216b4-1b02-4fbe-a72d-ab9fbc99d636	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
25c58733-6115-4ede-af5d-7f80ea0c5289	994216b4-1b02-4fbe-a72d-ab9fbc99d636	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
2d851350-feff-45af-b26e-91d63e0e5064	994216b4-1b02-4fbe-a72d-ab9fbc99d636	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
508d6ff6-efba-4028-893b-c758fd6dd01a	994216b4-1b02-4fbe-a72d-ab9fbc99d636	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
35f1d906-dbac-4da4-a4b8-5fa472f1c4db	20de7465-c67b-4358-b4f6-842518854d8a	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
da2ae6c9-0212-4eeb-9802-cc9732de2701	20de7465-c67b-4358-b4f6-842518854d8a	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
e5ffba35-5c4e-4f8c-86bf-68fd601a39a9	20de7465-c67b-4358-b4f6-842518854d8a	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
42fccb53-216a-4be4-9fdb-e6f19902b878	56258c7b-a6bf-4c78-80e2-310a0b941146	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
e0858707-afe0-499d-8219-79631522427c	56258c7b-a6bf-4c78-80e2-310a0b941146	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
f425a22a-b7f4-460d-8043-a72c73e10973	56258c7b-a6bf-4c78-80e2-310a0b941146	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
f3eaaae4-a08e-4b15-a5cb-cecfc60aba9d	56258c7b-a6bf-4c78-80e2-310a0b941146	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
d142b81b-5fcd-49a8-9a5a-e1138da54229	847c9b44-395d-43d5-90f4-cdea416c4cb1	2023-03-24 18:03:29.827	2023-03-24 18:03:29.827
345d5f59-608f-4ab5-b684-f3d96d0ba489	31c628a6-63a8-4d48-a32f-8d70ff243b4f	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
7074c0f1-a61b-43a1-87b6-1723b60da40b	31c628a6-63a8-4d48-a32f-8d70ff243b4f	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
e0e40128-d2da-4904-8215-d5e1396d2d2e	31c628a6-63a8-4d48-a32f-8d70ff243b4f	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
57a48e71-f07c-41e6-ab98-434499d55ab5	31c628a6-63a8-4d48-a32f-8d70ff243b4f	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
544459e8-5436-4b89-a03c-f402ec7fa9f5	14899068-d2be-4cee-9cbc-ab3ae406c473	2023-03-24 18:03:29.844	2023-03-24 18:03:29.844
20fda5e5-d30d-429e-9412-3760b1186cd0	a82abf72-d80c-4099-aaef-470ff25f74f8	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
b968f3a8-3a86-415f-a525-90ade1417398	a82abf72-d80c-4099-aaef-470ff25f74f8	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
667e5d23-d970-43fb-a2cc-670560052c3b	a82abf72-d80c-4099-aaef-470ff25f74f8	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
eef6c18f-1192-4439-97ca-a44f0a95bcb3	d4e5888e-1e65-4d2c-890f-6ecb4ff0053c	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
5ff7d87c-07af-4c51-bf1d-e361adadba06	d4e5888e-1e65-4d2c-890f-6ecb4ff0053c	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
d4f899ad-96b9-4bb4-833a-d01cc0aefcda	d4e5888e-1e65-4d2c-890f-6ecb4ff0053c	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
db2343ea-0da7-415d-a4e4-4a1ff2e8182a	47a90be1-6239-43c3-8039-8f6e3aaafb79	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
9efe3f38-bec0-480b-92f5-255b935b63fc	47a90be1-6239-43c3-8039-8f6e3aaafb79	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
d4a759a2-7702-4d36-9460-8c19a36208b1	47a90be1-6239-43c3-8039-8f6e3aaafb79	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
b13772b3-f6b6-494b-bfa2-c2cbecc7a1e8	47a90be1-6239-43c3-8039-8f6e3aaafb79	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
ce806e40-f6f1-4b3a-b2c2-8dda1881d9fb	4ed9ecf1-8c3a-42d1-a044-14c0644d09e2	2023-03-24 18:03:29.882	2023-03-24 18:03:29.882
2c9c9abe-f17b-4be1-be23-24c0de2df5e0	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
8f7e1eb6-5aff-4a4a-bd3e-9a9245ca62bf	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
61865745-9518-4890-b479-3b485f27446d	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
ae2eee93-56ee-4860-987c-c554a3f1f9cf	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
e5d0576d-d70f-42c6-bb1c-884ea1accbf5	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
c41546e0-8648-40f0-8eef-a7304773a2f2	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
a3973e98-17f8-40ce-b680-4e921589c858	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
1e9ba414-034c-467b-809b-64d84ad723e1	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
e2cb331b-128b-4974-87bc-9dd13426cb82	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
a2835891-9bde-4774-b59c-966eada28ddd	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
d7f203f5-b724-455b-bf77-fc6d8b1c9713	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
6a5ac81c-a447-4be3-84c5-fb690460ca61	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
a055376c-6281-4296-a406-295c4e0497b6	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
4dfb020f-88de-4f5b-9cdc-b75c7f86819d	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
809bbeaa-6c4f-4a50-bdb8-d3339debfc8e	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
d1454b7f-1b18-417a-be66-5239bdfff21f	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
171baa77-9aa2-4bcb-9c0c-d6557248ee5b	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
283aa9fb-0028-4288-add0-4020bdbe5c24	ad64b9b0-98b5-4b69-b88e-e600fee48bed	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
feafa330-8f02-4b27-8f68-6cda65b908af	ad64b9b0-98b5-4b69-b88e-e600fee48bed	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
3ed0554f-bea9-4f81-94d9-945ca41c8800	ad64b9b0-98b5-4b69-b88e-e600fee48bed	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
6b305c5a-aef1-4bc9-a70f-3fbba68d3956	33d101aa-6867-4149-99ab-878b2e088115	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
f79b1542-e465-4a91-8cd5-6b6dac4c5180	33d101aa-6867-4149-99ab-878b2e088115	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
297d73f5-9106-40b2-8a28-79e45134ad1c	33d101aa-6867-4149-99ab-878b2e088115	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
cc45479c-60e2-4da2-8244-0d775bc3f84e	33d101aa-6867-4149-99ab-878b2e088115	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
4556db31-c6f9-45e8-aae2-4df7848ec689	33d101aa-6867-4149-99ab-878b2e088115	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
9c7e733d-5385-4ec6-9c6e-1a079b186ea8	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
8a0f9adb-957b-410a-915d-7a1c611f58f1	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
81345b84-a0d9-44c9-a179-e0dd0ed641b9	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
a01f2d95-1b2c-40bd-877a-315a8b8fc79b	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
332f0c8c-1a22-48bd-9fbd-e49f69ba0f88	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
52f164c4-feb3-4366-9452-90a6c6071011	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
2325eddb-241c-430b-8062-ed2a77b51fa7	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
0b674f31-48f0-46fc-ba50-5e3c8ac6b37d	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
0923d05b-de2e-48bc-a3d7-f988fb725c98	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
88ba9822-9a03-49ed-b89a-999a17af356a	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
8a0a756d-dc03-4478-82e0-5cda8c196c03	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
cbe5f2c6-36cf-41ae-87b6-8bc5490fd9f3	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
7cd70ce9-c3e1-4a15-8e1e-7ec98df55aae	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
b3fc7177-4b1c-4262-91d3-188a26fda380	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
84f945a8-2472-47dc-843b-b382a55b2367	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
1a588091-d7cd-4da0-a8df-cb85a356b2da	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
6338566e-a86d-44f0-9812-a3aa9f1a7ca8	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
e1ee49ea-caa9-44a5-a786-8e7549f7c27d	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
fb457d42-430b-46a2-8517-a479fe3897cc	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
d88b0f7f-ba05-4c2a-a07b-57af5e477270	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
60714175-19ce-497b-8dff-fef2e9a28dfb	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
25973f3b-de5f-4831-84a1-291dfd36ba90	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
50ff0ac4-711f-404c-b02f-1019ab6f4adb	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
17560c0d-1773-421a-ad6e-ab0c49aa7435	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
039b63a5-dbf2-45cb-ab44-bf7b5345236b	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
0a9b94f0-9183-486c-84f4-93e3eef4b840	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
de3d7984-640c-4658-9f1c-e0fef9cd9d0a	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
6ddea5be-56f8-4106-b5b5-bb2f64048a0c	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
9455b602-2103-4a4a-b7dd-313285cef30f	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
e9a1cfc5-d389-4f24-b7e3-162891c519a3	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
6920153d-22ec-4dce-9193-ad8a080f4314	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
bbe54d3a-f17d-478b-ac1a-a229a3ce6e54	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
419633d7-2d8c-4b4b-b463-8e396fd477ad	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
9d82e335-000e-4b04-8b4a-0f6e6a350c13	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
4503543b-a831-4805-aa1c-3728194b31eb	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
20f04d91-6ad0-4602-ba52-009f191afd21	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
4cb9fa57-a1e8-4434-b212-20a873060c99	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
c81662f1-9283-4726-855a-8c762144f887	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
2c0ca770-dafb-4d4e-bbbc-9525cc35938b	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
c40bc7b4-865e-4586-85bf-a45a320eee98	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
6531af28-8bac-42c1-8597-046669682d29	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
2402bedc-0e56-41eb-9369-41b722b1e472	672e0f91-1a66-4a05-a614-076179532d30	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
77278c8b-6b42-4b30-b43e-d58275bb8b33	672e0f91-1a66-4a05-a614-076179532d30	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
7347efe4-0cad-4c66-8049-3d0605eb4df1	672e0f91-1a66-4a05-a614-076179532d30	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
c8b571d4-9b1a-4b65-9026-68e79038afc8	672e0f91-1a66-4a05-a614-076179532d30	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
7932476a-42e6-4c9c-bb5e-2bce0e8d45d2	672e0f91-1a66-4a05-a614-076179532d30	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
8b9fdd32-e298-4a25-be7b-2ad7905d97c6	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
c343851a-8aea-4d71-b6c2-afc6776073c1	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
fed5024e-3bab-47a5-864d-008ffe724873	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
4ef6f1ab-2cca-4a09-bdbe-d716183f841b	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
3ac4f67c-6050-4aca-8d4b-1955f4fbaa32	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
ad277781-5a0f-4822-96c3-1d698cb907d9	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
fd504d2a-1e96-418e-ba65-3c8cc27ffca0	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
198121c9-dbcf-4d89-81ad-d3546ba323e6	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
e7589e1b-3e02-424b-8d1f-874380434c73	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
2febfc09-e203-40c8-810c-f34c9283f09c	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
11c465ca-a956-416f-ac93-7b1c72467446	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
681c5bf4-3615-4e13-a92f-af1f56b5862b	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
56085ece-51a6-4349-b26a-50924de3a167	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
4426d1b9-075d-409f-ab66-8c017f9d3fdf	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
38bff362-248a-45cd-b52a-60a98b699446	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
7fb8c085-7b59-4d18-89c8-0bda6632e850	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
979e5653-3064-48cb-ae1c-2660f1cadeb6	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
b6f72919-bf34-4d79-9f74-fe93117f415e	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
1d9db9ad-27eb-41fc-a597-643b23688fc5	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
8038f07a-d5ee-42a3-a792-04da75c05354	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
79169bf0-a4d2-4c8a-bf05-53162560b187	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
e0bdc357-378d-40c1-985a-ee0dfc2680ad	2d40ba5b-d1e4-4eef-91ea-2b42813e1f3f	2023-03-24 18:03:30.186	2023-03-24 18:03:30.186
458844a9-c8a3-4ac5-9403-5e5df2fb1f33	2d40ba5b-d1e4-4eef-91ea-2b42813e1f3f	2023-03-24 18:03:30.186	2023-03-24 18:03:30.186
d250d231-c4ee-4665-bb41-f191aa8aae31	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
c50e14c8-e586-4cf0-97b9-2c9d48708b7d	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
2b5b985b-1b3e-469d-bc7b-dadb2bee7049	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
68f5bfda-0d42-4445-8778-7eec46eddce9	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
018c861d-a6cb-4ff1-8254-7ff3d50167aa	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
b28e0334-8ed9-46b7-9c20-70a2f5f89051	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
a1f4f786-e828-4e74-93d1-35b2061ce3f4	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
3f9f696e-8aa8-48cf-96d5-adad5bfe47a5	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
f860b432-6a20-431e-b8f5-e8fa790169ec	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
f71a3ec4-b73d-419f-94cc-7c8c6fde74d0	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
5fb74d30-277d-4c30-8649-2967c9d9dd7d	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
12adabeb-cb87-426c-927d-e5cee78b5e25	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
1cf28269-94a7-4b24-be60-31f5b0ccfb29	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
119365d5-9412-4ed7-8521-beabdc44f032	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
ff3c683a-b0f8-48c6-9e2c-219606bf22aa	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
022c7e21-9076-4182-9fc2-195f2334449d	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
15a2b174-51c3-4ea1-bf8b-2b6d0aa1699f	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
9d878a70-2d3b-4581-a795-2ec8053126b4	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
84948544-d575-4a20-af13-82d8350e091a	bb427bb5-16d6-45be-9219-af673da92879	2023-03-24 18:03:30.228	2023-03-24 18:03:30.228
3fcd7a07-21d1-414c-8f90-3bb9cd0a27e9	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
cfadf577-5471-4622-99b4-6a3bd2c89126	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
3fc6c60b-0131-44bf-b361-bf61bf98f85e	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
bf06449b-ea43-4b11-b166-961d8d1e91b1	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
96cc8338-6ef7-4c8f-a97a-64a1c083dacf	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
caf9d3fa-04f3-4502-9b1d-4cb1c726d930	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
010a83cb-2a9f-4454-90a8-63100a2665ed	78b891ea-af71-46a0-9bae-484a2cac0335	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
fdcd9cde-5b94-4192-bbe5-77474aac2555	78b891ea-af71-46a0-9bae-484a2cac0335	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
d1a0d060-d435-4fe1-b085-eed03398cfb6	78b891ea-af71-46a0-9bae-484a2cac0335	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
89e44c50-df88-4321-8f9a-0813c310548e	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
cc3ac85e-d0c0-4dab-9808-2f4ffc8ea71c	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
d541b60b-ff25-468e-9f88-d96d09f03c4a	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
f6dcb6cc-70c2-4cb3-9e14-4fe58b7dbebb	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
7b8bbb0f-6f90-40e2-923c-53850735bd69	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
b8f0dd2a-a6b7-46b5-ac36-13cdab6f0bd7	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
d4e995ea-be42-47f7-8cb3-24a48a2cc731	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
be88b287-86b3-44ed-a923-440ca99736f3	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
fa9d3446-a66b-4042-928e-f8c921b3f64e	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
6bba231b-9cf6-4c1c-bd7b-d5fd209e26f1	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
5ff94939-a0ad-4776-8380-3d676587aa63	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
49b97f08-04b2-4414-9da3-f41347b250e2	23dabc22-e363-4d28-8be9-450ea93ac194	2023-03-24 18:03:30.286	2023-03-24 18:03:30.286
a18630fa-c26a-4070-be37-273d1ea7681d	23dabc22-e363-4d28-8be9-450ea93ac194	2023-03-24 18:03:30.286	2023-03-24 18:03:30.286
c6261a62-e48c-4b7e-9902-35a03cd77787	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
52becd72-ba64-4696-a97f-27220b63656d	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
cf059a1d-af30-4725-b58b-fb26cc94aba8	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
51d11cde-af9d-4a33-9555-66a89bb14ba9	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
a3cb7eb7-e998-4917-8147-baa03f5098f0	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
5aa342c7-3f63-471a-8a23-15064c48823c	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
e4f6d472-0adc-4254-bd5b-fcf88543bc9f	0b40373e-963a-4ce7-8a7c-85b58c2eeb2b	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
5b58a7f8-9f9a-4ea5-b0a4-62cb8977fdb3	0b40373e-963a-4ce7-8a7c-85b58c2eeb2b	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
1d847c8d-b45c-4705-863c-70714ab97453	0b40373e-963a-4ce7-8a7c-85b58c2eeb2b	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
687a2862-af36-4399-bc59-364a647f4430	0b40373e-963a-4ce7-8a7c-85b58c2eeb2b	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
5a11c43f-8e18-4d41-b289-c7fb62ec7216	d0ddeff3-e631-438d-909f-ab7f9d05a7af	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
6e5daeca-5469-41c7-98b5-56fc58e4ee74	d0ddeff3-e631-438d-909f-ab7f9d05a7af	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
d122638d-9152-4144-98b1-6d21fecca394	d0ddeff3-e631-438d-909f-ab7f9d05a7af	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
257628a7-5126-47e7-a1f7-db236006beb1	d0ddeff3-e631-438d-909f-ab7f9d05a7af	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
46207ac2-64e1-4100-bb3e-01451a6137bb	d0ddeff3-e631-438d-909f-ab7f9d05a7af	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
e0b983a7-976e-42b2-9fdd-d3c291c99c2d	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
d9d5dfa9-e696-4e15-babc-6e122f1cf15c	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
a30f2eca-b718-486f-a305-44d080183a3d	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
ae9390be-3415-472c-b77a-99681f452f9d	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
cdf9367e-22b0-4f29-8601-3c95a8f59703	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
3c7ebfe5-992b-41c5-a25b-7dca2a5932f4	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
63e23e16-b508-4b6c-bd4f-52d727cb0904	1757aea7-7e07-4a79-85d0-92a92e27571a	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
61e8ce78-ecf0-4ae9-bc3d-5fb1ed8b0705	1757aea7-7e07-4a79-85d0-92a92e27571a	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
78af2656-3147-4926-85c0-44c52f1741a7	1757aea7-7e07-4a79-85d0-92a92e27571a	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
b3361b72-55e0-44f4-9b5f-0c50f859ea9d	1757aea7-7e07-4a79-85d0-92a92e27571a	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
7db6e3a8-02bd-4995-8ae9-3e05a42e1243	1757aea7-7e07-4a79-85d0-92a92e27571a	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
0629f94f-a54a-4bdd-989a-8e47dc034290	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
ac59c1d7-036d-489c-93f2-90b38f0d1c7c	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
fc8708e1-cb96-4d93-bc98-ec624ce6216c	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
08fe6d7e-eac2-4543-9fa7-ada2b0aecc2b	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
3cec35a1-26b4-4a80-b232-d519157c5cb3	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
256c5a6b-6853-4998-9b21-9e7374982d58	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
1b0a9a67-2928-4c6d-9a2e-fc32404c4672	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
69e9495d-fd65-4462-b8cc-b081ffff133f	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
a9984f67-f393-4101-a157-905837b1e4a0	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
1dce75c3-b9d4-4ec3-a6fe-573d51ddb51e	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
fa669bd7-ae91-4e96-bd49-a247e554cf8f	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
50a60b57-5f18-49e4-8630-a4ac1a8fb970	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
dc587a1b-2e82-4c6a-b9de-c4209d9c4234	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
65ae9980-ab81-4b46-99e6-6ae204940ec0	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
858b1501-5bb9-44f8-8e7d-1dbb275cd173	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
d0cb512a-06d0-40fd-a234-c1795e655ccd	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
ae6ee06a-7559-4c81-9192-997d3be5d5c6	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
4610c169-70ab-4f52-8b26-689d07641d77	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
0853c814-4523-4799-8d3e-64c0a80c0d39	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
c5ab93a9-a696-4c50-b2eb-282da1c99eda	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
96f4513d-6ac9-480e-b7cb-589e71b251be	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
09c44d95-d00a-4c73-99bd-d95a6c0b6306	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
0ba66866-9ea7-45e2-a9b7-a130d096e828	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
72d63f72-aa7e-464d-9ab7-c5222d48ede6	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
95a0a549-ffb6-426d-ba4e-b79f6ebbfcac	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
632f0b0a-ac8a-4906-b4f3-b3ad9fcb6cf2	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
f9098170-5066-400f-adbc-312747fa26b7	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
18464ec9-eff8-4752-8397-a13e9732855e	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
2e6e4645-f2ca-4f2d-b09b-adfdebeb1aff	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
771381ae-8309-4c50-b54a-00222915272d	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
2ce06bf8-316f-4e64-b6ed-4c9516a7bebe	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
3d7cf1c2-d788-4094-8ea6-381956c23bf8	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
7158dbb7-12cf-4a22-87c5-508b43c7e72e	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
8cfdbaac-1883-4246-8bf0-279fc353ee6b	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
dbef1447-ea68-46d7-bdec-40b014801730	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
fe2f86a0-8176-4582-88cb-09c149ad431d	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
1cb3249a-581f-493f-8ce7-c9df752b49a8	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
fdede15f-7823-4e71-b769-b074620d7c3f	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
6ce6904d-2cdb-4833-a59a-6105e3fbe0a8	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
1180ae91-c59a-4bba-8664-c2327dfda327	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
95f3d5e6-b00f-4b7e-a252-bbb62ab2b0b4	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
68d88b17-3065-4b61-b467-a494f0c54439	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
5eab1452-2e4c-4734-ba80-6e7e95622eaa	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
d4ab6b09-5914-4a45-a48d-47dc9bac05b1	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
fdf2bb22-99a7-4165-b04d-6a59ff8ededc	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
9e2ce002-d85e-4d98-9df2-cd81d6cf8071	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
10ae0374-6849-44d6-a5d4-62c43da7f71a	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
c333fc33-2a5f-4036-96a2-cd03a1d4466a	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
8e56a165-06e9-4b07-9144-450daa8c42ca	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
42d4d81a-63ba-4c03-a7a0-4f9f861dd99a	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
fefeb973-77cf-4423-882f-cd3fbdc2e924	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
4935dab0-204d-46a2-ba8a-cb3226044dcf	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
a1e22a68-a26d-4ad3-9fde-113198ab2058	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
3d2f7fab-b79e-410a-922b-5380ae9b916b	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
fc01eef1-27a2-4e3d-885e-090f87470666	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
55195276-f1d8-4d84-aee4-f9f57e035c80	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
3d628af5-6536-49d6-9b33-73d544b8248c	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
756a93b6-da40-4616-adca-66f7580764a1	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
b947b10e-43dd-447d-987c-13c55d53f940	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
2c1ccd5e-6838-457b-b1cd-eb12227e18dc	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
4d28cb46-2352-4fec-95f4-09e6ec5f53aa	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
3c0a1b40-0a86-4278-867a-3c5b275e7b7c	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
1a178c5f-57c0-4674-ad7e-1561543162bd	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
bf5eaaf3-c467-407d-9013-e8df66fa9b77	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
fd71459d-f6f7-4531-ac67-034e8564bd74	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
486c030c-9ffc-4b87-89b1-70495bf1db01	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
744b4f23-6db5-4392-a742-e38c8e2b8854	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
ea08291c-4e80-4b39-9807-05543be44bff	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
bde1d9b9-6a6b-423c-a13f-880eeefb0127	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
31177dcd-9485-43e7-a950-09050bdcf155	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
64ac0d8f-9049-4e51-a4d5-b320c1d9e15e	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
37e96c24-d127-4f14-9935-d1d8b330dd13	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
4a44f42d-6894-4ce6-8924-c32e5c760445	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
091e513e-cd1e-4d1a-994a-2cf5bedda1f9	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
b243f6aa-1f19-44c1-9b8e-5e10a3971a34	faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
2928ef71-db2f-4abe-a346-f3b9f421f2e2	faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
ce120375-980c-4eba-aad7-41a114a54053	faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
68db6a2a-5677-4a07-a7f8-671aae47ca95	faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
b2fd9f2b-56fe-4ec1-a377-f033d189b14a	faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
52f86fc4-c115-4244-8490-876df30b350d	61147bd9-7701-41da-bfc1-cf66b91ee029	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
ef3efb74-62ed-4f66-975c-205610768b10	61147bd9-7701-41da-bfc1-cf66b91ee029	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
eb800019-d181-479a-9a92-5fa02fddd480	61147bd9-7701-41da-bfc1-cf66b91ee029	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
a5b9eb88-8faf-430f-8dca-16c8d3413601	61147bd9-7701-41da-bfc1-cf66b91ee029	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
3f4a9752-e416-4d7a-b183-45d7308830ce	61147bd9-7701-41da-bfc1-cf66b91ee029	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
d23ca3f5-c47b-4fff-9781-ca8737857a20	172802c0-27ac-4224-a3a1-d02693572025	2023-03-24 18:03:30.651	2023-03-24 18:03:30.651
e71d9b25-b8f9-496d-92f2-9b896c018f6f	82191f49-87b3-4a56-896f-869a3e6ad49e	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
3b88de31-bd4f-4707-b252-7cd1b2697539	82191f49-87b3-4a56-896f-869a3e6ad49e	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
c4d483cf-88e9-47c0-98ba-800b3bb52a2e	82191f49-87b3-4a56-896f-869a3e6ad49e	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
657cafe9-435b-42f6-b691-6fd92436df69	92b6b061-18f3-4b2a-abc0-916aee1e6e7b	2023-03-24 18:03:30.668	2023-03-24 18:03:30.668
66b92687-6e1e-474d-9b08-66455fbaa1b9	b185bd11-bce0-4bfb-a4f2-5f6852e24b59	2023-03-24 18:03:30.686	2023-03-24 18:03:30.686
5b307dde-597d-43d9-8e5d-25bddda4bfdb	b185bd11-bce0-4bfb-a4f2-5f6852e24b59	2023-03-24 18:03:30.686	2023-03-24 18:03:30.686
0f9c2a47-512c-4cf0-896b-ea3ef3b4f42a	e70e48bb-a391-4f47-a82e-fe829d1b98f5	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
eca4c491-4880-435d-b229-1cd916d0e1d2	e70e48bb-a391-4f47-a82e-fe829d1b98f5	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
480cf7e1-3bb6-45ce-ab7d-fa67b5644412	e70e48bb-a391-4f47-a82e-fe829d1b98f5	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
89fe3bb9-bd7f-4652-98d9-81a60fdd4131	332d4983-ffae-4dac-876e-4d86743c1b25	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
c046a891-6393-4946-b8c5-c95658b28c33	332d4983-ffae-4dac-876e-4d86743c1b25	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
24512dc5-b061-48cf-b8cb-883c7d659731	332d4983-ffae-4dac-876e-4d86743c1b25	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
1db2ebf4-6d34-4258-97cd-ccc8e1de39c6	5883cbba-b8ac-4fb7-96e6-aa318ee73d90	2023-03-24 18:03:30.71	2023-03-24 18:03:30.71
cc669e6f-d92a-4e0b-997f-0371ad8c30a4	6e836e15-3511-4b5a-ac9d-ee26412f381f	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
42e8d08c-5e50-4e6f-bdb6-0c695239cd3c	6e836e15-3511-4b5a-ac9d-ee26412f381f	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
3d2f7c9e-8658-40e9-8a5c-d2cedd078c77	6e836e15-3511-4b5a-ac9d-ee26412f381f	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
b5959da4-b8e2-4576-be99-dcab1fbd2700	6e836e15-3511-4b5a-ac9d-ee26412f381f	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
8fe5827f-3c92-4d59-84af-2c471cde042d	397b540f-02b4-4973-abd4-b15c26dabbe4	2023-03-24 18:03:30.726	2023-03-24 18:03:30.726
1996b239-87db-45fb-a18d-5d4754a68788	397b540f-02b4-4973-abd4-b15c26dabbe4	2023-03-24 18:03:30.726	2023-03-24 18:03:30.726
334b1ac8-06c0-4061-aed7-441978d040fb	d8f63525-be32-4d33-a289-0d74454b8446	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
e09c8072-6950-4225-ab5c-c4546e8ac084	d8f63525-be32-4d33-a289-0d74454b8446	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
f01957ec-5b41-4dd1-a25e-73d82a4b983c	d8f63525-be32-4d33-a289-0d74454b8446	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
031e12ee-d357-4274-8772-f76857c55f99	d8f63525-be32-4d33-a289-0d74454b8446	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
04d6341b-119f-457d-8135-def24bcf56be	d8f63525-be32-4d33-a289-0d74454b8446	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
d6a04b48-12ca-4dc7-9c06-42f0ff9b89a0	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
55f98b74-57db-4af1-9955-0aadd7fb817e	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
22a5cf84-96bb-41e1-8f60-3c05f2f8c357	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
c59f0e8a-75d6-4d3b-9545-95666ff9234c	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
d943c4c2-1582-4884-9be3-03a97ba09412	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
6b1b5da5-08f5-4bb8-8208-b9ecc8339333	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
44122e6b-97d6-46d9-b327-235706bb41ea	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
a89f0336-a5cb-425b-8060-7107955d2913	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
6e321cf3-d54f-4adf-be85-a51cc87cde41	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
2e5e3146-20b0-4cc1-8a03-4636ea2b05da	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
286add80-ab83-41de-a0fe-7426013a1ebc	5c824c54-b625-41ba-800b-569a324d9330	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
f9215910-7688-4dbf-8c3c-cade5e2fea85	5c824c54-b625-41ba-800b-569a324d9330	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
b86ec8d0-ada8-4a27-a26e-96e43d11c1cb	5c824c54-b625-41ba-800b-569a324d9330	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
0c6b2ec6-77de-4f31-b5eb-06b54638ef71	5c824c54-b625-41ba-800b-569a324d9330	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
ed7402e5-2c02-4ee9-954c-607d4361cbba	5c824c54-b625-41ba-800b-569a324d9330	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
a9be8c2f-2bad-425d-a1ea-7f6a929537a7	9276e06e-d1e1-4dac-a365-020cf2ee2ad4	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
cbc632cd-7baf-4e8a-9af3-a151a8de117e	9276e06e-d1e1-4dac-a365-020cf2ee2ad4	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
fff4872d-eb52-47aa-a137-5c6d221ddcbe	9276e06e-d1e1-4dac-a365-020cf2ee2ad4	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
dcd7200f-8e0f-4e10-9555-244a9279b981	9276e06e-d1e1-4dac-a365-020cf2ee2ad4	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
54424168-1bf3-4b08-b0e4-7871cc3656dd	9276e06e-d1e1-4dac-a365-020cf2ee2ad4	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
c4c7c8b2-4844-49fe-bd93-944f66127f88	04ec782f-1d50-44a9-a943-c94310cfd30f	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
488ccf99-9cd4-41d8-8b4b-6e114bdc300c	04ec782f-1d50-44a9-a943-c94310cfd30f	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
e930b1b8-e2ed-4191-9dde-ffcf4839d63a	04ec782f-1d50-44a9-a943-c94310cfd30f	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
01bffbde-667e-40fe-84bc-e45f74975ba4	04ec782f-1d50-44a9-a943-c94310cfd30f	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
7f3a7b8a-6d5f-4678-941d-9cd2566e4f31	04ec782f-1d50-44a9-a943-c94310cfd30f	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
1f12bcf8-a24b-4e09-8c2f-43fe928fc98a	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
5bd8a380-954b-4535-b7ef-1123f4645fad	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
d9837034-f12e-482d-8279-d87f9ffd3e45	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
6da18447-eee2-4b30-9641-56aafbacee7a	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
c61f49e1-bb7f-4b2c-a13d-64ec32e2fc5a	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
1854e946-9e1c-4063-a875-f40c1c7edaff	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
056da0f2-6efe-43f0-9630-6981dad99bae	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
cae3add6-6b84-428f-83e9-e58287b7de60	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
e1173266-1da6-46f0-93d5-9e9a542e37fe	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
8e75b885-6685-43a8-96ba-09a6c09d28dd	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
451389e7-2318-49c4-9bb3-eaf3b18a16fb	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
f1239149-9116-4cec-83a0-de4c9c78f91b	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
dbcc6e74-4a31-4a1a-9a98-bd14944017ee	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
25ec1d53-84b3-4d7b-9a1f-c0d42763d1dd	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
41caec6f-9dea-40fa-a39a-89d9035b494b	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
589560ee-f6dc-45ce-bf2c-f0d1c64fd3cf	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
9c781aee-20e3-470a-a7c7-727b740d81a1	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
173ab249-fea8-4b25-979e-6e8fdbf28762	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
c36d9f94-9228-4a02-a541-3105e5c44141	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
f5581d04-2dd3-41b1-a7a5-764d3f813faa	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
7d29c84a-93c9-4efa-8d04-033243462871	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
6565782d-6180-40a6-84dd-30060ac273a9	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
67c85313-a457-4c07-90c2-21eb80a74189	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
aa803bac-cb3b-470d-b59b-d3f4cdb5ac91	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
053f8ecc-ffd6-4acc-9d2f-e73c97714a79	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
3dcd439a-8910-4328-86f4-9ad444f02c2d	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
ea0e67d2-9e2d-4503-b2b6-b070efe70896	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
6464584c-ecb6-44b5-98b4-a2cb8bf10575	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
e0bf3d47-51c5-45c2-925c-16ffcf45b62f	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
1f4f47af-fe22-49f9-b466-675fc93b2ebc	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
814bc42d-7653-4973-84b6-84ae2c1e980a	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
0cb963cb-30fc-4ced-8dc4-216cb049f5f8	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
4b2ac13f-f055-43ea-b7d0-fb870611a639	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
6ca075de-80f1-4ac1-806e-01b4449803e2	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
bb44280a-2ef7-4ab9-a446-3ab7ee0bf269	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
2b2849a2-b423-4dcd-a04b-4fb0fffe5d6e	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
57408acd-a711-4bf8-a9ae-965cd06ec747	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
41cceb5f-e03c-421d-8d72-a9aac029a802	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
82cbbf8d-7a26-4236-b3eb-d67e583561a2	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
eea43d5a-2a66-4842-b319-a65360470bff	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
e7531112-2e2e-444b-b093-67a392eb4f02	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
c823855e-3631-47ab-8768-ded094da0949	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
dab38fef-adb5-458f-99a9-cf0d6bfefffc	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
4390388d-b67f-442c-be54-584a8fbcf6d3	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
202a4c8a-cbad-455a-a1e1-062120cfd868	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
8b88536c-d4c8-4bdb-a91b-435bb25d2ae4	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
02e5c679-5251-4ca8-9ed2-ab94dea4d0eb	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
35cb2be8-18f5-4bb2-8061-da96587ec68f	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
34fbf08e-914d-48e0-82f7-98eeaed64da0	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
e6f3a4a8-7c57-48d2-8e0a-50c110eb1df5	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
8de29dc9-10ab-41e0-8db0-3ff12d9d092d	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
1bebafd0-d965-424b-91d9-e17bae1ecb3a	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
2a560e0c-0f70-4383-8504-4a22daea2c21	0d33f7e9-a80a-4927-a7f0-c6be670b2f74	2023-03-24 18:03:30.998	2023-03-24 18:03:30.998
66ecf0bf-9b0c-4ef2-9ffb-5718f590227e	0d33f7e9-a80a-4927-a7f0-c6be670b2f74	2023-03-24 18:03:30.998	2023-03-24 18:03:30.998
d4a61ae3-f1f0-475c-9164-9f952182d668	4dde4b4e-7079-4603-a1db-e43bdf59d12b	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
7272344d-8c29-4e75-b8c2-06aa49616c34	4dde4b4e-7079-4603-a1db-e43bdf59d12b	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
50de5863-fc0c-428b-a655-3013d88c2ee1	4dde4b4e-7079-4603-a1db-e43bdf59d12b	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
dfad7db5-b536-406f-8703-228de9af7c4e	6d6a3915-4f87-49c0-9050-80351256976d	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
19c8102e-bebb-4906-a52a-b59396e20b59	6d6a3915-4f87-49c0-9050-80351256976d	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
5f88d0b7-1f0a-4d69-9476-a4c542b662ac	6d6a3915-4f87-49c0-9050-80351256976d	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
0d872253-c867-44da-94df-cf8e2227251f	6d6a3915-4f87-49c0-9050-80351256976d	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
66223b60-6b94-4a9c-a2a6-5e4393077bd1	6398d8fd-e173-4751-ab95-7e03ba3ee868	2023-03-24 18:03:31.023	2023-03-24 18:03:31.023
f4a42ba0-f773-4660-81f4-8916abcfa458	6398d8fd-e173-4751-ab95-7e03ba3ee868	2023-03-24 18:03:31.023	2023-03-24 18:03:31.023
728625ec-9147-4e47-89bf-b62cd2f26b90	243ebac3-bd83-4a4a-b9ee-41b90e550d37	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
22dc5726-990b-451e-b68e-c0f19be12809	243ebac3-bd83-4a4a-b9ee-41b90e550d37	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
ae536ce2-2ad7-4df6-a08a-abbd8d8bec05	243ebac3-bd83-4a4a-b9ee-41b90e550d37	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
02d93520-8193-4303-8af2-c8a18f8e8364	243ebac3-bd83-4a4a-b9ee-41b90e550d37	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
ecf72a23-382f-46e5-8969-730da7580ff6	f69b17dd-545d-436c-a1eb-6355fdaf3ffb	2023-03-24 18:03:31.041	2023-03-24 18:03:31.041
0db30e16-aa17-4495-8ab6-42a0442dedd5	9c9b35a8-982d-47cd-89df-9f34e687e4fc	2023-03-24 18:03:31.047	2023-03-24 18:03:31.047
41cf7a1c-3265-4e2d-a0e4-b71f18c5af0d	86628d1e-cff0-4a7a-8e36-d19b47358e92	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
fe128081-72cc-4434-8fcf-a9e2d967d241	86628d1e-cff0-4a7a-8e36-d19b47358e92	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
293263d4-cd0d-4f7f-98b9-781332235141	86628d1e-cff0-4a7a-8e36-d19b47358e92	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
93c6c23b-0cd6-473d-ae96-4fa17de8b685	0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
0755594e-0bd4-43c2-9522-2ce5fa7cf3e9	0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
45101d38-fa5e-4967-a971-262abe0cf56a	0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
1f552a42-82ef-43db-9c42-e5fae8ecda12	0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
e6bd2bd5-a50c-476a-bf3c-7c0deeb0c188	0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
98de7a1b-e091-42e2-9d98-4111597aa656	5df3ee26-a777-4716-b201-e93ccd7fa64a	2023-03-24 18:03:31.117	2023-03-24 18:03:31.117
17a534f1-83b9-4823-b0c6-10f412633954	5df3ee26-a777-4716-b201-e93ccd7fa64a	2023-03-24 18:03:31.117	2023-03-24 18:03:31.117
583c8de1-1a6b-401d-a930-c813b6f71c7a	8a2f711b-8654-44aa-b9e8-527b1e2fe9b5	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
bb8700a2-8739-4ab8-8d4a-ea1ae3b1c4ec	8a2f711b-8654-44aa-b9e8-527b1e2fe9b5	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
031d0e70-b665-4738-b91c-d8e1eb46ba7c	8a2f711b-8654-44aa-b9e8-527b1e2fe9b5	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
5a5d2747-efcd-4ce4-b657-28dab1908d4b	8a2f711b-8654-44aa-b9e8-527b1e2fe9b5	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
8614e485-bb85-4ab3-9b7c-5ed784bdb04a	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
18c0121c-ace6-4f84-891f-a5b03d90d01a	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
54b541cd-e56e-4ebe-932f-f6e9c8d4855d	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
4376f618-611f-4992-9d42-78846302d475	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
1eb5397e-2269-4c4a-b1da-afefe704c849	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
1ab23e57-3f15-40e8-83d1-2da8a1aa17b0	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
52522716-7ec8-427a-bfaa-769926bd9828	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
a3e3514a-9185-4e15-9e5c-acebe13475e1	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
1e334d20-e36a-424c-a0c0-faaa9a0a672e	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
865d8eb1-24d6-47ea-aa67-f7fef082abc8	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
f30d7102-eef0-413e-9c82-7f3d4f2ee992	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
483a8a4c-a46f-4803-9290-87e36b3a9303	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
39e7d29b-5d13-45b8-a818-159755bf865d	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
3d2f643a-69df-4e99-89cf-46092038e6fc	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
c661467d-1559-49f0-a72b-36e1299e417b	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
eadb9c33-2831-4cf4-a381-a1b675905465	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
37af395b-36ea-4465-9e1f-3a01e3473184	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
6b6cf356-312c-4957-9627-07045228d028	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
ee2773b5-a475-4dc2-a0cf-2955a48b880a	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
fb93d7c0-3de1-47de-9d14-7b1fe256d5df	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
26d4a24d-3ef9-48b2-a8b6-73452645505a	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
fc5b0bf4-7af7-4d32-8f6f-a87314e776dd	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
badc9b63-2a26-40cd-93a4-81f7cd7c5cb7	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
232ce975-a41a-47c2-9dbf-594a2d551220	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
fc7bc72e-9262-400a-99c1-22caa2ccc9f4	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
bc287c7a-9191-4709-8da2-ff1faf3b36f2	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
89d58dda-2877-4a64-aaf0-bcd003a8fe21	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
c816c324-a332-4701-8457-f1aa5b11f3b8	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
1429493f-4b44-4bc3-a375-e1f88bd34c20	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
da1f01f7-61c3-47b9-8dc4-ad7e714fd62d	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
07d3a719-4c7b-4001-ba12-6f8e4acd4a78	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
4d5a92ba-03a3-476f-be53-8e3208a0e442	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
964650c8-cd62-41ac-8886-ad078a5a4476	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
3ec7df8b-c4d2-4b83-9a36-bf85984eac64	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
8034943a-2780-435a-a981-ef3daa2628a6	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
40a1eaf2-86d2-443d-a15f-d42aff625bed	66f2f1a2-b204-4ca7-8903-afb8e314e86d	2023-03-24 18:03:31.225	2023-03-24 18:03:31.225
71c0c516-bee1-4bdc-8268-b7cc69de87f4	66f2f1a2-b204-4ca7-8903-afb8e314e86d	2023-03-24 18:03:31.225	2023-03-24 18:03:31.225
d348c3b5-c783-4bfb-a9a9-aa11efd51b26	5bd68116-d7b0-4c2e-a355-b214fe8288eb	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
f4d437f3-281e-4c6c-bfcc-4a119d652dc7	5bd68116-d7b0-4c2e-a355-b214fe8288eb	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
60a81a88-6969-45f7-a327-b840cf7c2879	5bd68116-d7b0-4c2e-a355-b214fe8288eb	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
5eabdc91-75c9-4428-b9eb-b86e02d53dc6	5bd68116-d7b0-4c2e-a355-b214fe8288eb	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
eec1e5cf-e638-472e-8637-c08e9c6cbb73	5bd68116-d7b0-4c2e-a355-b214fe8288eb	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
4d98d489-574a-4bcf-a0e9-801bb858d5b8	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
6c21045d-d99d-4d8f-812d-ff0572559921	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
6d3959ec-3628-4e81-b257-aa9aad257b33	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
5868ddcb-5794-4696-84d5-fa70e7c64133	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
95c27eba-1647-4863-b059-899cb99660b9	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
54b4ef0f-9106-4147-ab56-db461c62fb86	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
831331f1-161a-4c54-87d3-e6d6af1d5644	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
91fb5891-74d3-4840-b976-56448b4a9fa7	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
8376726a-026d-49bc-922a-1c41a35a572c	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
94567ac3-ade7-49d6-a557-6c0f269eb729	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
6bd28836-a519-47ed-8e1b-b39a12ac64f8	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
7e029276-b387-4161-ae71-c694d7f2c392	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
cde56d54-19f6-4f17-af0e-f265653d48cc	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
e9117cb7-a9b6-469f-ab26-a89c32cf41ef	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
cef2835c-fedb-4f65-811a-c2ccfeb1a404	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
a0631992-bca4-479a-9163-f19b98dcc0f5	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
c7a7a5fc-683f-4ced-a228-860f12fc30cb	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
bdf4e2dd-4f24-4fd6-b4dc-6223c08610a1	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
f345132c-08fa-4445-ac10-906139c37b51	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
82f52316-d44d-4303-8094-7349658eb0fe	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
400a8361-0372-405c-aae7-8e799a9a1252	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
fdb0c724-417b-4d59-9fdb-e39cf4318c81	0baac6ed-e780-4cc1-a5cd-8ced30f736e5	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
1ad332c8-03f4-4966-8c1a-08baf60f3a49	0baac6ed-e780-4cc1-a5cd-8ced30f736e5	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
b3c301bf-ee15-4c38-b8f5-cb6189dade0b	0baac6ed-e780-4cc1-a5cd-8ced30f736e5	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
ff60a970-506a-4917-a962-55c007ecdc59	0baac6ed-e780-4cc1-a5cd-8ced30f736e5	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
2887e4ad-70c5-4b08-b36c-fe5d9e9ee2cd	0baac6ed-e780-4cc1-a5cd-8ced30f736e5	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
d751c482-4e92-440b-884d-351bae98ca24	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
9bdfae74-7fd4-4afa-a0c0-267a846f1425	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
a7efa68a-4a28-4f17-abe4-a5c94b2b3a97	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
e054a9cd-def0-4c2d-ae87-596bc634da36	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
2962dece-8cae-4670-9c97-e87e48839230	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
8ac5f154-ba0a-4507-b64f-f465e9c897b6	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
fcc59c3a-bc47-4294-8158-cdc5262e37d9	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
ecd91915-d16b-4b41-aa67-9ac47e0bac23	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
1cc83a45-2bed-4a50-badf-d373f66523a7	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
96041adb-8901-45dd-88fa-e9165ed01ace	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
8badaee0-dbe9-4b97-8d4b-3f65f7afed89	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
e7359065-3372-41b6-8d5e-a9173b534d99	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
8d2e5294-c604-44cb-ba88-b2c3c7528c05	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
d4e1e448-c73a-4ef8-8f77-4685058b0e82	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
4e5aeca3-6334-49b2-918f-8d4457241a47	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
a5053650-db10-4a69-be57-7b053e7e85cf	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
\.


--
-- TOC entry 3471 (class 0 OID 16568)
-- Dependencies: 226
-- Data for Name: QualificationTranslation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QualificationTranslation" (id, "languageId", type, token, "precision", occurence, "isOriginalQualification", "qualificationId", "createdAt", "updatedAt") FROM stdin;
fdeb5be2-55eb-4776-a48a-5b4804b5f520	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	dot	appelée Nsuba constituée d'éléments visiblement simples mais très sympathiques	1	t	e9318ded-65b4-450c-a9a9-86c00d8977dd	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
df6d2f45-7c16-42df-b987-8902009974fd	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	partenaires	qu'on appelle Dia'an	1	t	bacf51c7-0ac5-4dde-9238-cc3905065f30	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
0764a733-004a-4d80-ad31-d53f44cfc010	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	puberté	afin d'éviter qu'elle ne perdent cette virginité avant d'être mariée,  ce qui la rendrait impure, et sans grande valeur, avec pour conséquence que la dot soit revue à la baisse, et chez certaines familles, côté marié, elles pouvaient exiger l'annulation du mariage	1	t	875a3d69-cf50-46c4-baa2-f97f9c3aff56	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
1ac1acc8-2629-4117-9901-13d320a63ea7	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	enceinte	(lorsque l’on estimait de la bonne moralité des parents, on supposait de la bonne éducation de l’enfant et donc du bon comportement de la futur mariée	1	t	b5d3ec3e-a901-4d36-bba4-f9edf8b893c2	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
551c1879-b101-4f04-a524-327af6b71d92	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	père	qui chez les Bulu est le garant et le détenteur de toutes les bénédictions nécessaires pour la réussite de l'enfant	1	t	9b80ee06-73bd-487b-b00d-dcb8f5770e83	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
56b61352-88e9-4d34-a69c-326a195974c4	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	mariage	consenti	1	t	30370680-e3e0-4027-a133-9da0a570d3bd	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
cf966ef7-23ac-4865-876b-3d5a76a7bf88	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	Bulu	venant en partie du fait qu'ils n'étaient pas de très grands artisans du textile	1	t	d87ae8c9-78fe-48a6-947f-cf5957dbde56	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
e0bca3ba-557e-4e1b-9aa0-de70327bbf06	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	ordinaire 	se couvrant avec des feuilles d'arbres et leur OBOM	1	t	4aefe4df-424e-43d7-a6a6-cf0fe22fd46d	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
2a0f8738-7f03-461d-8148-4fe22fd1b64c	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	proprement 	Étant des hommes de la forêt qui dispose de feuilles d'arbres en abondance	1	t	e18e259c-4cd5-4f97-916b-de98d015f840	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
7498b386-678b-4684-b2d7-13fdd09058d0	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	simplement 	avec des argiles de différentes couleurs	1	t	a796a1d9-a28e-4075-be58-d73cfc595990	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
0d4b3804-0c34-42b5-b1cf-ac3a4ad6ac2c	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	escargots	On les confectionnait en les perçant pour faire passer une liane.. Ce collier faisait également un bruit qui rythmait la danse des mariés lors des festivités	1	t	e07f3e37-9b06-45fe-b03c-aca655cb5044	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
f3c9e2e4-3137-4ed7-b743-ea3b99c798cf	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	naturels	fleurs, coquillages de petits mollusques pour les bracelets	1	t	63a33144-1eef-43b7-9ade-e5d2401c8323	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
a54a7db0-3799-4998-8ba8-cd6417f5df33	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	pagne	un même tissu servait à toute la communauté des années durant	1	t	345f117e-b05a-4b5f-9f0f-bcc1d2459478	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
b879203b-639f-416c-b743-53854368fef8	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	agée 	qui devait organiser en collaboration avec les autres plus jeune, tout le volet restauration, et c'est pendant ces occasions qu'elle transmettait à ses cadettes en mariage dans le même village les secrets pour bien conserver leurs homme, comment se tenir au village	1	t	236e5a6b-979a-486c-b1b1-a158831128a1	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
eaa58d7a-b750-4b58-b832-8a20675f963d	a016b260-36f6-4535-b20b-ea7af618ffc3	action	préparés	L'enfant du village est considéré comme l'enfant de toute la communauté, et par conséquent toute la communauté participe à chaque événement comme membre d'une même famille	1	t	cdf71810-9352-4ff6-941e-84bfb65bade3	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
2781f702-1db3-4178-aa39-daddb373f2f8	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	dot	Composée de : Noix de cola, d’un porc, d’une boîte d'allumette, d’un wisky distillé localement à base de jus de palmier à huile ou de jus de raphia, d’une chèvre destinée à la famille maternelle de la femme, du vin de palme, d’un coupon de tissu pagne, d’une dame Jeanne de vin rouge , d’un gros verre à vin rouge, et d’une somme d'argent symbolique	1	t	79c313a0-fc09-4f00-900f-486c13e38a15	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
7be67571-5b13-4615-a9d4-844cbe121bc2	a016b260-36f6-4535-b20b-ea7af618ffc3	action	acceptée  	ce qui se traduit pendant la cérémonie par l'acceptation de la somme d'argent symbolique par le chef de famille de la femme	1	t	3acdd354-7f17-486c-b93b-1b3ab51d12d2	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
caa6f9f6-4347-402d-a43f-5e5c63457647	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	repas 	préparé par les femmes du village sous une ambiance festive, animée par des groupes culturels	1	t	01dd73fb-15f2-40d4-9087-3e48011a49a2	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
0977e8f7-817c-4366-9853-1b451b25d3e7	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	père	étant le chef de famille, et dépositaire de toutes les bénédictions de la famille	1	t	a2d00d52-4079-4470-baed-4352c951d514	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
36770caa-50fc-4d65-83e6-d27bbe679456	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	prêtres	et surtout des pasteurs, car de nos jours, la communauté est majoritairement Chrétienne Protestante	1	t	ba7a38b1-87d7-4630-b4a5-4ecd54e2eb95	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
46b8f0a3-9427-45b2-a7a1-3c4e899543e1	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	femmes	elle n'avaient aucun mot à dire, ni de choix sur son futur époux, et n'avaient pas le droit de refuser le choix fait par son père	1	t	50ba3094-5ad4-497b-b991-4f08f9600868	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
185e34b3-eb32-4a86-b9c9-0ffec1bf3114	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	bikie	l'argent symbolique	1	t	3541cf6a-09d4-44d5-bb56-e2731089543a	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
4c855ce6-5368-4a1d-b8a2-2a8847e296ef	a016b260-36f6-4535-b20b-ea7af618ffc3	action	servait	mais toujours à la seule décision et désir du père	1	t	d8cd15ae-5182-4de1-a1d1-3cd284e79bb8	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
db149cf0-3117-4c6e-8c77-e89a44df5fe1	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	atouts	d'ailleurs un dicton reconnu sur l'étendue du territoire dit : "le bulu peut  avoir les poches vides, mais la bouche est toujours pleine"	1	t	0a6f6e18-6ad9-4ac1-a287-fd4021a98fde	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
1471ebb0-5753-4431-ac7f-cd49739c72f8	a016b260-36f6-4535-b20b-ea7af618ffc3	action	transmettre	les méthodes, les procédures, les rites, la prise de parole	1	t	af5f451f-ac97-41f9-8b52-ac0260e0508c	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
103c1b75-d109-4b81-a907-a13d4fd9b91c	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	mariage	la dot est devenue très chère car les parents de la femme demandent de très fortes sommes d'argent aux prétendants, et beaucoup d'autres biens	1	t	4757f1a8-f2c6-437a-a2c6-8f0096e8dce3	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
ea660c5a-4f41-4c9d-a3ef-2fc189b1443a	a016b260-36f6-4535-b20b-ea7af618ffc3	action	acheter	généralement les mêmes choses qui sont demandées plusieurs fois au prétendant en plusieurs étapes, et cela s'assimile à doter la même femme plusieurs fois	1	t	18a700f5-178b-4937-8ff7-986cf7b72a94	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
659f8b4e-aeea-45d9-b15d-04cd4ce62172	2d585863-97ad-4543-86cf-d83bcc67e635	action	escoger	para casar a una mujer ) a la pareja primero entrega ( dan de casar a la mujer	1	t	0fc26184-d1fe-400c-92f4-38b942c9e307	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
07a6f2e3-1b81-4ce8-90fb-b301ff08b483	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	joven 	hombre edad de 19 años	1	t	a27aa165-4100-4eff-bd82-065b35e067cc	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
08bc1ce0-574c-47ba-99da-c7251bf9c4f7	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	luego	de manera inmediato hacen como un intercambio	1	t	34440c7f-aac6-4213-aedc-d3ddf246d20d	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
bbee3b59-387b-4db8-a0be-8742c4afa353	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	familiares	los padres del joven y padres de la señorita tios tias sobrinos sus abuelos abuelas vecinos	1	t	48c123e9-62d4-418e-9fe5-78a07cb13340	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
1459620e-3734-4045-b021-2a7cf81f0dca	2d585863-97ad-4543-86cf-d83bcc67e635	action	entregan	dar que se case con la mujer	1	t	2acf241b-2eef-451d-85a6-66e7b56e1f28	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
7606181b-095a-408d-9d37-c2e4ee24c1ef	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	hermana	ala hermana menor del joven o ala mayor cuando no hay	1	t	e8dfd2ca-1e5e-434b-918d-54249be362c6	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
a5e968b9-a235-48a3-9c65-36419b4969e7	2d585863-97ad-4543-86cf-d83bcc67e635	action	intercambio	cambiarse de hermanas doy mi hermana tu medas atu hermana de eso se trata	1	t	53ee7737-12c3-4f11-bd01-9361440be094	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
e79474d5-4523-4753-98c2-2d287e259d62	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	aveces	6 de cada persona	1	t	79704410-5f9f-48fe-8fab-451d134969a4	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
30ff7ec6-4906-4280-b1dc-8e0259cf848d	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	cercanas	personas que viven del mismo comunidad o vecina mas cercana	1	t	122139f9-4b22-41ab-b876-95530c5bd3d7	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
70846300-6bbe-4187-a121-54dc998a0b8c	2d585863-97ad-4543-86cf-d83bcc67e635	action	buscan	ver persona correctas o que le gusta asu estilo	1	t	96e65b36-f76c-4235-8155-c081c0f5c2df	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
7fdc1ab8-fb19-4956-8931-2f12fcf6eac4	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	lejana	persona que vive en otros comunidades	1	t	2500c1c7-d308-4a79-872a-6cdeb5611f79	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
d44452ff-630a-43e6-b728-94a42aa0fbd4	2d585863-97ad-4543-86cf-d83bcc67e635	noun	familia	una familia es una pareja que une para vivir unidos	1	t	552f282c-3a3f-4cb2-a6c0-76f6a8f263b1	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
97d718dd-b1d7-4f70-baea-7cd0afe08179	2d585863-97ad-4543-86cf-d83bcc67e635	noun	territorio	un territorio para nosotro es vida limite que tiene selva	1	t	d0caca45-2257-4436-bcb2-8684d4319f31	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
7ff98307-e044-4edb-b0a8-734421d11b84	2d585863-97ad-4543-86cf-d83bcc67e635	noun	uyen	cuando hay fiestas sevan a escodidas	1	t	5ec6ea5f-f11d-478f-a6b4-171d660232e0	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
4ce3d11c-598c-42d5-8b9d-cce08390097d	2d585863-97ad-4543-86cf-d83bcc67e635	action	utilisaban	se vestian	1	t	2d2646c8-a29a-417b-bf34-e63197a598c5	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
832ec50e-c397-45f1-bb1f-e328b0246867	2d585863-97ad-4543-86cf-d83bcc67e635	noun	vestimenta  	falda de ñachama y para hombres hilo de algodón  y la lanza utilizan siempre en todo	1	t	022369d3-c99f-441d-b645-d2410d36980f	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
ec058505-d5be-47b8-accc-db1225d1a96b	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	elaborados	 los dos padres se visten	1	t	eebfcd25-022e-4134-829e-54d1414031a3	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
262261fa-ddb6-4abd-9dac-abf0709b09b8	2d585863-97ad-4543-86cf-d83bcc67e635	noun	matrimonio	el evento realisan en casa tipica  de noche con fuego de cadela usan como luz	2	t	46a3e2e8-b0d8-4dfd-86fd-258caf910704	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
720ab8d8-94d5-4b9f-a336-ea0ea0fdb408	2d585863-97ad-4543-86cf-d83bcc67e635	noun	lanzas	cada hombre va con 5 lanza en hombro y una suelta en otro hombro	1	t	25b97b26-9323-4f23-9cba-63d18f0abaa4	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
97914015-33ad-4732-a9b7-e9efa7127f45	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	casamiento	hay barios cantos , canto de union por pareja ,canto de familias alegres etc	1	t	3666f899-c9da-476f-aae9-5f9684d97ac3	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
f355b85b-b774-4348-bf0f-28506bf726d7	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	tambien	 vestidos tal como usan los padres	1	t	3ceedbd8-7e9c-4c12-9ac2-5a6b0be5bfba	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
7f455ec5-b020-4e57-8f02-2a103653fef0	2d585863-97ad-4543-86cf-d83bcc67e635	noun	elavorados	hechos por sus padres y madres	1	t	5f4ac6cd-b384-4a99-9147-5cbdac4c90fb	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
681dd697-2094-4fc7-a8f0-aaf8a267e9cf	2d585863-97ad-4543-86cf-d83bcc67e635	noun	plumas	 de guacamayo ,lora papagayo	1	t	dc63aa84-bfbf-4b18-911e-bf05363797b8	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
ea5995bf-3c0d-4b14-9e39-da4a34e7a0f9	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	despues	entre waorani de diferente clanes en territorio	1	t	1c30044a-506e-4a68-8e67-8dd8c074b132	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
17332a64-a029-4536-ad6c-3b024efa5d5d	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	occidental 	cada clan vivian en tres partes diferente  .es decir en diferente provincia	1	t	c31de327-2530-40a5-b064-166e6141afe4	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
24669e16-dbd8-4ef7-8d61-571d8a6a1cf1	2d585863-97ad-4543-86cf-d83bcc67e635	noun	mantaza	asecinar a un pueblo o persona	1	t	e2ffa93c-0f22-48a6-bd13-9399b42fab98	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
3269a50f-7e50-4ee6-a54d-bbd70860da1a	2d585863-97ad-4543-86cf-d83bcc67e635	action	celebran	tomando shicha  de yuca  ,chucula de maduro canto ,danza	1	t	decd543f-c092-459a-943f-8f6fe7affe0a	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
9f4f3310-46ac-4e53-99f0-e5f290fb48a2	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	todos	familiares 	1	t	bda8d43d-e9e4-42ca-ba31-8370fe5a3c08	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
5834e8b2-b205-4763-bd02-11dc8df928c5	2d585863-97ad-4543-86cf-d83bcc67e635	noun	cantan	una persona va cantando primero despues aconpañan en todo canto	1	t	86d05fb0-7f90-4f75-80d6-adf768002f6e	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
b144ad57-13ae-4ee4-a6b2-4375a4e3a9a9	2d585863-97ad-4543-86cf-d83bcc67e635	action	trabajo	 trabajo en limpiesa  cortar arboles con acha	1	t	bf009def-8198-43dc-bb0e-8dd9eed7b4ec	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
3c4dfe40-4a24-480a-b88d-c9425a13a1f5	2d585863-97ad-4543-86cf-d83bcc67e635	noun	guerra	con otros clanes waorani o tagairi taromenani  pueblo en aislamiento voluntario	1	t	ee38be13-8d38-4518-bed6-7b6ef433950d	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
86718b7d-c6db-4c38-aeb9-3b90dc760dcc	2d585863-97ad-4543-86cf-d83bcc67e635	action	trabajos	es algo que me va dar de alimentar con esfuerso que ago	1	t	54aa677a-141a-4cc8-a319-9c6a055205b2	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
5ce28b3e-366a-4e62-8656-2498740a0f05	2d585863-97ad-4543-86cf-d83bcc67e635	action	regalan	 dar algo valioso o resivir	1	t	21126f99-2eeb-403c-b961-664aeef468c7	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
07062619-197d-45e9-8889-f08c4dbc855b	2d585863-97ad-4543-86cf-d83bcc67e635	noun	lanzas	material hecho de chontaduro tipo porta bamderas	1	t	5e93a604-8807-4120-b8bb-1a8c7adaf9bf	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
af622fbc-b4c0-449f-9e07-494fd66b0c06	2d585863-97ad-4543-86cf-d83bcc67e635	noun	guerra	con otros clanes waorani o tagairi taromenani  pueblo en aislamiento voluntario	1	t	1fe276e5-87f6-42c5-9172-bd12876b978f	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
e1b4a7dd-4928-4ed0-a34a-a7eb770c39b3	2d585863-97ad-4543-86cf-d83bcc67e635	noun	coronas	tipo diadema	1	t	4d8d0ebd-5d12-4b2a-b1d0-46b8c6b9008e	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
55a28d83-a842-417c-87a6-9eec3e99fca0	2d585863-97ad-4543-86cf-d83bcc67e635	noun	shigras	tipo bolso para huardar cosas 	1	t	fc82ecc3-cb9e-4f3e-a5d7-dae26c82ee99	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
d3673199-d6bf-4bcd-a41c-aa345d49f22b	2d585863-97ad-4543-86cf-d83bcc67e635	noun	hortigan	una planta que es para aser dolor ,tambien sirve para quitar dolor en cuerpo	1	t	d26d14bb-3220-4df3-b674-b981989f745f	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
b6142856-b7b9-46c9-b0bf-aef45f31ef60	2d585863-97ad-4543-86cf-d83bcc67e635	action	castigan	dar golpe con piola de bejuco en los braso de ambos	1	t	d00d2287-ef1e-4bfc-a83d-89af3fce3eef	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
e3886460-e89d-4c0b-950e-b2e30b592327	2d585863-97ad-4543-86cf-d83bcc67e635	action	para	que no separen que an unido	1	t	c31db8fa-1350-451a-94c5-c5f0a780eec9	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
5a1dc894-e290-435f-9c89-dd3304fb9453	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	mal	que no moleste a otra mujeres y sean honesto en todo	1	t	cda63e32-de65-41a4-9daa-964d8425dba9	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
f312504c-31ef-4255-b472-3170ee6da941	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	anciano	de 72 años	1	t	1766088c-5dec-4cbd-bc3c-a5406383b883	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
91fefd75-f6a8-47cf-9df9-f3413fca2a40	2d585863-97ad-4543-86cf-d83bcc67e635	action	da	entrega a mano del joven	1	t	196ebf49-89c8-4b8c-9136-528bc200d667	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
d0827c71-2d98-4371-9710-a696b02c4594	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	juntos	viven juntos trabajan juntos	1	t	6d4114ab-8e7d-4c76-9978-96d3cdde4cf4	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
abe1542a-804d-40bf-8d99-f468cd263b14	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	autoridad	una persona sabia con respeto	1	t	4cd0ac5e-dc61-4a77-848c-8a5f2f3649e9	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
fffed953-f644-4d5c-8d72-c20825093e97	2d585863-97ad-4543-86cf-d83bcc67e635	action	superior	que ve todo lo bueno	1	t	84ce4032-1b92-493c-890b-894a333afa83	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
d08c223c-4ba8-4bfc-b1d4-39db9a4bb1d8	2d585863-97ad-4543-86cf-d83bcc67e635	action	alejan	salen de sus comunidad	1	t	6c312450-70b9-4290-a1e4-15b23c82142f	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
9fdb7345-af8d-4656-8b15-60584dc925f3	2d585863-97ad-4543-86cf-d83bcc67e635	noun	hogar	casa o comunidad	1	t	6f5aea71-2a32-43d7-9dca-074cf725462c	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
28a651a6-efdd-43b2-82ff-1c4a112a5522	2d585863-97ad-4543-86cf-d83bcc67e635	action	unen	formar familia casarse con una mujer	1	t	1cbd0da6-dae2-4965-95c4-55b041d31a32	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
8dd36fd1-5746-4a9e-bfac-9d1c33cbd2aa	2d585863-97ad-4543-86cf-d83bcc67e635	action	van	a pie , canoa bus transporte	1	t	9bbe557b-546b-46bc-8518-9a40553084af	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
b3f43ec7-3c96-478e-b614-f5915517a681	2d585863-97ad-4543-86cf-d83bcc67e635	noun	fiesta	en cada año se selebran e cada comunidad por fundacion de poblacion. Asen fiesta . Eso asen en actualidad antes no asian, hay bebidas de shicha ,alchool ,sigarillo algunito consumen droga en actualidad	1	t	4f6f4d32-69e8-4c07-b46d-ec007ff52a3b	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
edef7441-42dd-4c4b-9ecc-83a109bc3929	2d585863-97ad-4543-86cf-d83bcc67e635	action	asen	dar de casar alas mujeres a los hombres	1	t	b02a7685-15bf-4283-9256-df859bf7a698	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
a581f8e3-353d-40c2-9dcc-206d02375b44	2d585863-97ad-4543-86cf-d83bcc67e635	action	casar	alguno sus propios padres dan de casar y otros dan de casar por que  ven que la pareja esta juntos	3	t	a9c38850-0912-4c78-b46d-d5c38c488171	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
12d21cc0-2591-45cc-98ce-b9fa0e1dac82	2d585863-97ad-4543-86cf-d83bcc67e635	noun	defensores	velar por la tierra que no aya mas invasores ,como madederos mineros casadores ilegales	1	t	6361346d-affe-4cfa-b5a8-898bc4532712	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
1fe8b1a6-254f-49df-8bab-50ddf37c0491	2d585863-97ad-4543-86cf-d83bcc67e635	action	pedidos	para tener mujer	1	t	709e0011-5e5c-4dc2-92eb-65abdc0b1f72	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
133532d4-5319-4e18-b9d5-8f2cd6121f33	2d585863-97ad-4543-86cf-d83bcc67e635	action	intercambiar	dan una mujer y resivir tambien	1	t	13edfe2f-e99b-4146-96ca-50668935107d	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
aacff8e8-ec74-4f96-b869-f7ef7bc7ef40	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	lejanas	persona de otra comunidad o pueblo	1	t	034c0f4c-aac4-405a-8672-16ab3d28b506	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
b3ee192f-893a-48f2-b3ba-8f89a19389bc	2d585863-97ad-4543-86cf-d83bcc67e635	action	octener	 para tener	1	t	da0b08bc-9ef9-4e9f-b533-11f41b418887	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
1d65be1b-7a68-470a-b79b-c2bcdf6b703e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	mantaza	despues de asecinar asus padres	1	t	0fc2c665-ad60-454b-8871-b3801a46094c	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
9fb15825-37a7-41de-a8b0-154cd234b16a	2d585863-97ad-4543-86cf-d83bcc67e635	noun	lanzas	hecho de chonta duro con punta finas con eso acesinaban	1	t	57cfe6aa-8c8f-447e-b97e-d291138d8e9b	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
f06896ed-67d4-4123-922e-ecc1d212938a	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	madres	alos que vivian sercanas lo mataban	1	t	c909604e-33d5-4a60-869e-f02660582a07	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
9e2d19be-2f65-4367-8b24-11d615abfe62	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	huerfanas	sin padres ni madres	1	t	6a015867-5a9e-4475-880e-7d36855321ef	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
18e6792b-57d3-42d5-8b50-5cea0335b078	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	hombre	30 años en adelante	1	t	4c5fa0f4-ff0a-4b37-be07-d779d11116cb	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
f5ab1087-5856-4842-a44b-4542bd330610	2d585863-97ad-4543-86cf-d83bcc67e635	action	llevar	asu pueblo	1	t	aebc5d95-c64a-4035-b0e9-4b146239a769	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
0ab5fe49-3bd2-4561-971e-1aa11380254f	2d585863-97ad-4543-86cf-d83bcc67e635	action	convertir	en su pareja	1	t	d7a5d41f-fcf9-4400-8182-2e26323ee7a1	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
72aeb746-5004-451f-a7cd-e239aed1ace1	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	mujeres	unos 10 mujeres	2	t	a0b540c5-9680-43df-b929-6d74494d00fe	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
ba8ebf6a-971d-4dd5-97fd-bea7d8a88717	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	Solo	ver alternativas	2	t	7337dd5d-20e3-4a3a-87cf-f5003ce51843	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
8c7053d3-dc43-4aae-83cb-09e3d5f5f877	2d585863-97ad-4543-86cf-d83bcc67e635	action	venganza	los familiares que quedaron vivo tubieron que matar para recuperar lo perdido solo con eso	1	t	dadde0a6-15dd-4bcb-9809-1b6e2142e819	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
e3450f2b-da6d-4c30-82ab-c10886e3ee68	2d585863-97ad-4543-86cf-d83bcc67e635	action	recuperar	volver a tener lo suyo	1	t	c9e28d03-59e4-4263-ab16-5cb9b4e084aa	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
a34a9d81-1d23-4a8b-adee-0f5de6668b56	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	perdido	8 a 10 años	1	t	07dddc41-ce38-4b29-bfe8-ddeecad95bd5	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
2f1519af-5633-4919-af3e-001cd60bd300	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	mujer	vivir con una pareja	1	t	0cb55939-1e83-4a12-ae34-e22bad2acaad	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
46c7dc03-26a7-4204-9e5f-d7545262820b	2d585863-97ad-4543-86cf-d83bcc67e635	noun	territorio	tierra donde viven	1	t	5e219002-6253-4b6c-84bc-55dbeff64df9	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
fcb4c206-24e0-4fd8-851f-219b0ddb5589	2d585863-97ad-4543-86cf-d83bcc67e635	action	tranquilidad	solo alejar un poco mas lejo o esperar que la persona mala se muera eso esperaban buscar la tranquilidad	1	t	e76c8363-29aa-40d6-a657-91dab4bfa65e	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
3cbbe2c2-6fef-4c1d-8c70-9ce4f8122249	2d585863-97ad-4543-86cf-d83bcc67e635	noun	Guerra	antes no ubo paz  matanza con lanza a lanza por limite o enojo por muerte de un niño o pareja	1	t	cc463ade-b8ba-4726-b062-ef5d1d855d51	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
7106800b-fbe6-4b15-9e16-6fea96486b3d	2d585863-97ad-4543-86cf-d83bcc67e635	action	vivir	vivir resistiendo de grande peleas a lanza   ser fuerte en todo no tener miedo a nada defender su limite como jaguar tigre	1	t	299673ce-e4f0-4e45-af03-a5cda5ca2253	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
026db464-e92a-438b-ba2b-f688b42c41b8	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	them	their friends' daughter or son	1	t	c4e4b70b-cdfd-421f-a9e5-b924d75bd90f	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
c323f3bc-9ea0-4528-b44a-7c9051b326c1	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	love	when boys touched girls' hand or body with the purpose when they crushed on them	2	t	25c58733-6115-4ede-af5d-7f80ea0c5289	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
dff71f99-7678-4531-95a2-09d541e49e13	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	believing	If a boy touched a girl and suddenly entered her room, it was a shame and it effected her dignity. That's why boy had to take responsibility and if he didn't take responsibility, she could request compensation from him	1	t	2d851350-feff-45af-b26e-91d63e0e5064	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
bc47d35b-fc11-4c7c-89d4-1ed21273fb9d	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	rejected	 to protect their dignity from getting bad images around their environment and among their friends	1	t	508d6ff6-efba-4028-893b-c758fd6dd01a	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
3c46b59a-9da7-4299-a31f-dbd89d4cd7cf	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	son	who were suit with their children and  most parents liked such as educated people or the people who came from  powerful and wealthy family	1	t	35f1d906-dbac-4da4-a4b8-5fa472f1c4db	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
b761ddce-0b69-4e2a-8b56-6c9d41bf7a53	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	purpose	if I touched her, she must marry me to protect her dignity	1	t	da2ae6c9-0212-4eeb-9802-cc9732de2701	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
485fecac-e43a-426f-a711-904fe8801993	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	girl	accidentally or with purpose	1	t	e5ffba35-5c4e-4f8c-86bf-68fd601a39a9	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
438f6ac2-77c2-4d41-9294-dcd4f6764a20	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	religions	the people who are Buddhist or Christian or Hindu or Muslim or others	1	t	42fccb53-216a-4be4-9fdb-e6f19902b878	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
6e1cda75-6697-4d64-9709-f0e0872dc60a	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	room	every boy must enter girl's room at night time before marriage and to be legal as husband and wife according to ancient tradition	1	t	e0858707-afe0-499d-8219-79631522427c	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
4d4f30ac-9e53-46c4-b9f6-815574a9ec13	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	village	 the villages or cities or state that not Gone Thar Phaung Village	1	t	f425a22a-b7f4-460d-8043-a72c73e10973	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
289add9e-3328-49f1-89ca-e578c71c8849	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	want	the clothes of other ethnicities, religions and foreign if they wanted and prefer	1	t	f3eaaae4-a08e-4b15-a5cb-cecfc60aba9d	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
f7bc466d-4d5c-4d85-b7e7-6d315ed0ead5	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	tradition	even they haven't celebrated the wedding yet	1	t	d142b81b-5fcd-49a8-9a5a-e1138da54229	2023-03-24 18:03:29.827	2023-03-24 18:03:29.827
096e0a7c-b894-4c55-a999-51aa5b3b8e4f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	couples 	choosing those couples that must marry only once in their lives, they must never divorce with their partners and must not have bad images that betraying their partners	2	t	345d5f59-608f-4ab5-b684-f3d96d0ba489	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
6c9a7bc6-4e1c-475b-93bc-c09f45ad1d15	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	wish	to be royal couples, to face together and count on each other in every situation in the whole of their lives like them	1	t	7074c0f1-a61b-43a1-87b6-1723b60da40b	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
caa861ad-d5b8-4231-afb2-b40253dd467a	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	feasting	rice, only vegetarian currys, vegetarian desserts	1	t	e0e40128-d2da-4904-8215-d5e1396d2d2e	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
cf68aa52-c85f-4591-b7d5-2483d09c03f6	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	booth	(built it with bamboos and leaves for the guests to eat and take a rest when a lot of people came in this wedding and there were not enough places to treat the guests in the house	1	t	57a48e71-f07c-41e6-ab98-434499d55ab5	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
a28fa334-1f58-4a71-8604-52d6e177762c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	currys	no eggs and meat	1	t	544459e8-5436-4b89-a03c-f402ec7fa9f5	2023-03-24 18:03:29.844	2023-03-24 18:03:29.844
c8304ed4-1f14-402a-90f8-f28bfcf5b864	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	contract	signing their name on the papers infront of the lawyer or the villages' leaders , their parents and their relatives	1	t	20fda5e5-d30d-429e-9412-3760b1186cd0	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
4885616c-fe3c-4bec-a32d-ed1e8d9a4477	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	people	if they didn't agree and didn't like him , they could reject him and they could call him and his parents in the village leader's house with many authorized people to give compensation for he had done if he had touched her hands or body	1	t	b968f3a8-3a86-415f-a525-90ade1417398	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
32b09258-2ab2-4f67-a064-19212572468a	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	cheroots	Burmese traditional cigar and used to use it to invite the guests befor we didn't have any invitation letter	1	t	667e5d23-d970-43fb-a2cc-670560052c3b	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
7ef9cccd-4998-4fcc-afcb-96a0727236d0	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	reject	when he came and proposed her	1	t	eef6c18f-1192-4439-97ca-a44f0a95bcb3	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
4d3dac31-332c-4b6d-b922-020e2bc30ea6	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	compensation	money	1	t	5ff7d87c-07af-4c51-bf1d-e361adadba06	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
2aac0c12-574e-4495-9514-a3b25794b1bf	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	cigar	it is long 3 to 4 inches cylindrical shape , making from tobacco plant	1	t	d4f899ad-96b9-4bb4-833a-d01cc0aefcda	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
8ee03d0f-181c-415a-86ec-774f89e733b0	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	husband	according to our tradition, the time that after her parents and she accept his proposing and before they celebrate the wedding	1	t	db2343ea-0da7-415d-a4e4-4a1ff2e8182a	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
b03a65ad-3ae4-4f1c-9535-4ab094a6d712	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	other	the people who are foreigners and different ethnicities , different traditions and culture with us	1	t	9efe3f38-bec0-480b-92f5-255b935b63fc	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
1e7595ba-8aa1-47d8-9d2c-07a842ca796c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	people	if they don't celebrate their wedding and stay in this village	2	t	d4a759a2-7702-4d36-9460-8c19a36208b1	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
2d7c2da1-ba9e-47f7-96d0-f71befc1e6e6	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	worship	the declinations of their glory wouldn't spread to them	2	t	b13772b3-f6b6-494b-bfa2-c2cbecc7a1e8	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
7fe2b38b-b476-4b52-a6a6-e270df65dced	2d585863-97ad-4543-86cf-d83bcc67e635	noun	corea	komë	2	t	60714175-19ce-497b-8dff-fef2e9a28dfb	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
0c8b2d1a-e5d2-4725-b2a9-bbb6bac18456	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	village	the glorifications of they, their parents decline and if the people who are their siblings, grandparents, niece and nephew believe in Talah Kone religion stay with them in the same house, they also can't worship	1	t	ce806e40-f6f1-4b3a-b2c2-8dda1881d9fb	2023-03-24 18:03:29.882	2023-03-24 18:03:29.882
4f9351ae-2829-4378-8a20-1e2f25d931bf	a016b260-36f6-4535-b20b-ea7af618ffc3	action	fabriqué 	tout le monde pouvait extraire l'écorce, mais seul l'artisan du village maîtrisait le tissage et la couture	1	t	2c9c9abe-f17b-4be1-be23-24c0de2df5e0	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
03849ed0-be4e-4c7e-811a-6fa4e8c2c03d	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	arbre	quelques noms d'arbres :Andom, Aloa, Eloi	1	t	8f7e1eb6-5aff-4a4a-bd3e-9a9245ca62bf	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
cb75e893-3128-4c87-aaa8-b043e67affea	a016b260-36f6-4535-b20b-ea7af618ffc3	context	rivière 	à environ 1km du village, coule toujours cette rivière du nom d'Evoum	1	t	61865745-9518-4890-b479-3b485f27446d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
9d5e5bb5-7544-4193-af5d-06230d5860e9	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	faciles	l'effet de l'eau de rivière bien oxygénée permettait également d'élargir l'écorce et d'éviter les moisissures	1	t	ae2eee93-56ee-4860-987c-c554a3f1f9cf	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
e2e52a77-ced4-4e66-ac2e-a13ffb94b266	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	dessus 	pour extraire les parties dures	1	t	e5d0576d-d70f-42c6-bb1c-884ea1accbf5	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
2e26d121-cfef-462e-b51b-39440c1f4371	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	écorce	l'environnement influençant le type et la qualité des rayures de l'écorce, chaque tissu avait des motifs différents de l'autre	2	t	c41546e0-8648-40f0-8eef-a7304773a2f2	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
f6ab5212-11a8-4d13-8484-d84bebc140a9	a016b260-36f6-4535-b20b-ea7af618ffc3	action	entretenait 	lavage, séchage, raccommodage	1	t	a3973e98-17f8-40ce-b680-4e921589c858	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
14fc459f-2959-4887-833f-ae3942d183d6	a016b260-36f6-4535-b20b-ea7af618ffc3	action	culture	choix de l'arbre, prélèvement de l'écorce	1	t	1e9ba414-034c-467b-809b-64d84ad723e1	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
aafeece5-019b-4f82-9278-8a58171b9f07	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	base	lorsqu'on désirait un costume spécial	1	t	e2cb331b-128b-4974-87bc-9dd13426cb82	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
d4c64136-06f2-487d-883b-edee21d87371	a016b260-36f6-4535-b20b-ea7af618ffc3	action	semait	beaucoup plus lorsque les arbres se raréfiaient	1	t	a2835891-9bde-4774-b59c-966eada28ddd	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
7cce9c7f-01f8-482c-89c8-102fedf4ecaa	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	écorces	pour des tenues de fête et danses rituelles	1	t	d7f203f5-b724-455b-bf77-fc6d8b1c9713	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
00047ce3-8d4e-4e90-9b39-02ff22f64cae	a016b260-36f6-4535-b20b-ea7af618ffc3	action	prélevait	à l'aide de morceaux de bois bien taillés	1	t	6a5ac81c-a447-4be3-84c5-fb690460ca61	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
7fdc63b9-7f8b-4de2-989f-d94b0d8c004b	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	supérieure	cette partie est bien mature et permettait d'obtenir des fibres très solide avec des motifs bien développé	1	t	a055376c-6281-4296-a406-295c4e0497b6	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
07eace0a-d6c3-4f10-b58f-7ba98c7816d4	a016b260-36f6-4535-b20b-ea7af618ffc3	action	tissage	fait à la main	1	t	4dfb020f-88de-4f5b-9cdc-b75c7f86819d	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
058e6ad2-9e9a-4ce5-8297-2125ef29b46f	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	rigides	se rapprochant du Jean	1	t	809bbeaa-6c4f-4a50-bdb8-d3339debfc8e	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
df0589e9-9ece-4175-b3eb-40fd26cbf8b3	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	maillage	également fait à la main car nos ancêtres n'avaient jamais pu maîtriser la technique de fabrication des machines à tisser	1	t	d1454b7f-1b18-417a-be66-5239bdfff21f	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
8b1d5833-011a-4232-afb1-b5f39ac59471	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	souple 	idéal pour la confection des hauts	1	t	171baa77-9aa2-4bcb-9c0c-d6557248ee5b	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
6c1eb7de-9f7b-477d-ad0c-87078593c90f	a016b260-36f6-4535-b20b-ea7af618ffc3	action	pouvait	lorsqu'on ne trouvait pas d'arbres avec la couleur ou les motifs désirés	1	t	283aa9fb-0028-4288-add0-4020bdbe5c24	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
c27c3228-96f9-4184-aea3-6dfb09a33c2e	a016b260-36f6-4535-b20b-ea7af618ffc3	action	teindre	avec de la sève d'arbres, ou des solutions obtenues en écrasant certaines feuilles d'arbres 	1	t	feafa330-8f02-4b27-8f68-6cda65b908af	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
a0325a41-8714-4bc0-a69a-c82adf688d94	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	naturelles	car les arbres de couleur, offraient naturellement certaines  teintures	1	t	3ed0554f-bea9-4f81-94d9-945ca41c8800	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
09fc7b98-c796-4e1f-8853-e1538b8c48ad	a016b260-36f6-4535-b20b-ea7af618ffc3	action	couture	faite à la main, avec des cordes d'arbustes et des lianes	1	t	6b305c5a-aef1-4bc9-a70f-3fbba68d3956	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
2ce8c089-4ac9-4b18-97f6-2ec616ccc3e1	a016b260-36f6-4535-b20b-ea7af618ffc3	action	découpé 	à l'aide d'un couteau ou d'un coupe-coupe	1	t	f79b1542-e465-4a91-8cd5-6b6dac4c5180	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
c21d9090-7db0-4aaa-94fc-6547e3f50eb1	a016b260-36f6-4535-b20b-ea7af618ffc3	action	apportés	suivant la commande et donc l'utilisation du propriétaire	1	t	297d73f5-9106-40b2-8a28-79e45134ad1c	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
3b561e45-7032-4d0a-bac7-288656b98ffa	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	illustrations	ces motifs étaient différents selon qu'on était chef ou de la lignée, notable ou de la lignée, ou simple membre de la communauté	1	t	cc45479c-60e2-4da2-8244-0d775bc3f84e	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
58f2c090-bed9-465e-8d8f-215b29d57edf	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	usage	fête, rite, ou habillement quotidien	1	t	4556db31-c6f9-45e8-aae2-4df7848ec689	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
dd29ce2f-3514-4d96-9863-08e1b8b592f1	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	Bulu	Clan de Bantous du Sud Cameroun et peuples de la forêt équatoriale	1	t	9c7e733d-5385-4ec6-9c6e-1a079b186ea8	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
88c951e1-e4a5-41ae-b147-c92a6d361ad2	a016b260-36f6-4535-b20b-ea7af618ffc3	action	réalisaient	dans l'enfance de nos parents il y a environ 60 ans	1	t	8a0f9adb-957b-410a-915d-7a1c611f58f1	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
6856e350-f812-44f6-b675-115b74e19695	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	costumes	culottes, chemisettes, jupes	1	t	81345b84-a0d9-44c9-a179-e0dd0ed641b9	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
34e27114-2ec8-423b-96cb-12333b6341e4	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	tissu	fibres d'écorces d'arbres travaillées	1	t	a01f2d95-1b2c-40bd-877a-315a8b8fc79b	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
9ab11d4f-8168-4f3a-a607-866159d63046	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	arbres	choisis en fonction de la couleur et motifs souhaités	1	t	332f0c8c-1a22-48bd-9fbd-e49f69ba0f88	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
99e6e183-0d41-452e-a569-4c3a8982daf9	a016b260-36f6-4535-b20b-ea7af618ffc3	context	forêt	sur un territoire bien délimité afin d'éviter les conflits avec le voisinage	1	t	52f164c4-feb3-4366-9452-90a6c6071011	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
478c704c-fba9-42f8-ae6f-86e03af9dc7c	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	dense 	des milieux de vie vierges, avec une très grande diversité d'arbres	1	t	2325eddb-241c-430b-8062-ed2a77b51fa7	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
a62f40f3-db54-4ae3-8fd1-ce0634ae5eeb	a016b260-36f6-4535-b20b-ea7af618ffc3	action	agrémenté 	pour enjoliver	1	t	0b674f31-48f0-46fc-ba50-5e3c8ac6b37d	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
949d70f7-3d30-4c48-96f9-c3d0a89442cb	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	fibres	des fleurs pour des événements ponctuels, puis lianes et feuilles d'arbres plus durables	1	t	0923d05b-de2e-48bc-a3d7-f988fb725c98	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
fb03ba8b-919f-4bc4-96a8-846fc96b6e72	a016b260-36f6-4535-b20b-ea7af618ffc3	action	cache	aussi bien pour les hommes que pour les femmes	1	t	88ba9822-9a03-49ed-b89a-999a17af356a	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
71735490-8876-411a-9d2e-284b078c2e8b	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	pygmées 	plus proches voisins des Bulu dans la forêt équatoriale et qui ont jusqu'à ce jour la pleine maîtrise des différentes techniques de fabrication	1	t	8a0a756d-dc03-4478-82e0-5cda8c196c03	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
38db9cca-b157-4aa0-87b6-09e694d3f9bb	a016b260-36f6-4535-b20b-ea7af618ffc3	context	étaient	bien avant l'arrivée des bulu	1	t	cbe5f2c6-36cf-41ae-87b6-8bc5490fd9f3	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
ee2f0fbe-48cb-4e05-aa2e-a6867845768e	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	premiers	habitants originels des forêts	1	t	7cd70ce9-c3e1-4a15-8e1e-7ec98df55aae	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
0e3600b3-477e-4bd3-a227-4e577a78b4fe	2d585863-97ad-4543-86cf-d83bcc67e635	context	antes	hace mucho años y siglos que las abuelas y abuleos	1	t	b3fc7177-4b1c-4262-91d3-188a26fda380	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
35b3adc0-4bb5-47f1-a55a-0994e7e6d577	2d585863-97ad-4543-86cf-d83bcc67e635	noun	tela	wegota	1	t	84f945a8-2472-47dc-843b-b382a55b2367	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
b570bc06-ac62-428b-a954-a82ce1407a54	2d585863-97ad-4543-86cf-d83bcc67e635	noun	falda	wego	1	t	1a588091-d7cd-4da0-a8df-cb85a356b2da	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
575b9b48-0bc5-4829-be6f-5e4daef19340	2d585863-97ad-4543-86cf-d83bcc67e635	noun	llamado	ñashama , wego	1	t	6338566e-a86d-44f0-9812-a3aa9f1a7ca8	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
a6361ff6-aa83-445b-a153-c3b2aad225e0	2d585863-97ad-4543-86cf-d83bcc67e635	noun	shambira	one	1	t	e1ee49ea-caa9-44a5-a786-8e7549f7c27d	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
519fc037-2f8f-4a5b-964f-4df9d0775ca4	2d585863-97ad-4543-86cf-d83bcc67e635	noun	fibra	one	1	t	fb457d42-430b-46a2-8517-a479fe3897cc	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
10a890f2-3922-4572-8137-0dcc560cb2cb	2d585863-97ad-4543-86cf-d83bcc67e635	noun	algodon	kõõ	1	t	d88b0f7f-ba05-4c2a-a07b-57af5e477270	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
ea4cf993-eeba-4fe0-9f51-a14f9a1ce97c	2d585863-97ad-4543-86cf-d83bcc67e635	noun	balsa	gamewe	1	t	25973f3b-de5f-4831-84a1-291dfd36ba90	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
b92cff39-4e6d-47c5-8eea-fd0170ace614	2d585863-97ad-4543-86cf-d83bcc67e635	noun	aretes	dikago	1	t	50ff0ac4-711f-404c-b02f-1019ab6f4adb	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
fbeb8e73-1a52-4661-98bc-023fbb76f421	2d585863-97ad-4543-86cf-d83bcc67e635	noun	befuco	otome,orocame	1	t	17560c0d-1773-421a-ad6e-ab0c49aa7435	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
2ea2bce5-cb65-425a-8d7e-7dc4583906df	2d585863-97ad-4543-86cf-d83bcc67e635	noun	plumas	oõma	1	t	039b63a5-dbf2-45cb-ab44-bf7b5345236b	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
927e162d-c0f1-460a-85a1-33e756f4aeef	2d585863-97ad-4543-86cf-d83bcc67e635	noun	guacamayo	ewe	1	t	0a9b94f0-9183-486c-84f4-93e3eef4b840	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
7b998d2a-be71-41c8-b87f-680df0a2a6b0	2d585863-97ad-4543-86cf-d83bcc67e635	noun	lanzas	tapa	1	t	de3d7984-640c-4658-9f1c-e0fef9cd9d0a	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
30774789-2532-4d76-8325-aa3b0a1f1d69	2d585863-97ad-4543-86cf-d83bcc67e635	noun	chontaduro	tewe	1	t	6ddea5be-56f8-4106-b5b5-bb2f64048a0c	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
0c9c0f02-c5bd-41c2-90fb-aca9681c702c	2d585863-97ad-4543-86cf-d83bcc67e635	noun	faldas	wego	1	t	9455b602-2103-4a4a-b7dd-313285cef30f	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
163d7c0f-eb55-4e6f-a403-c616fe7dd717	2d585863-97ad-4543-86cf-d83bcc67e635	noun	fibras	ongueme	1	t	e9a1cfc5-d389-4f24-b7e3-162891c519a3	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
a018b4f1-1989-470d-8c31-ea535ce15cc6	2d585863-97ad-4543-86cf-d83bcc67e635	noun	shambira	one	1	t	6920153d-22ec-4dce-9193-ad8a080f4314	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
17f8ea73-0a30-4c7b-ba77-8ff0ffbcc787	2d585863-97ad-4543-86cf-d83bcc67e635	noun	algodon	kõõ	1	t	bbe54d3a-f17d-478b-ac1a-a229a3ce6e54	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
f5344e08-4ccc-444a-bfd0-826f7c177450	2d585863-97ad-4543-86cf-d83bcc67e635	noun	corea	kome	1	t	419633d7-2d8c-4b4b-b463-8e396fd477ad	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
08213e0c-7e98-4624-b1a8-5d75f33b5e9f	2d585863-97ad-4543-86cf-d83bcc67e635	noun	corona	okaboata	1	t	9d82e335-000e-4b04-8b4a-0f6e6a350c13	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
3cca04c8-37e9-4d0c-8dc4-dd991abc57b1	2d585863-97ad-4543-86cf-d83bcc67e635	noun	befuco	otome	1	t	4503543b-a831-4805-aa1c-3728194b31eb	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
ad200f63-d5e2-4cb3-ac0b-e3705de4c351	2d585863-97ad-4543-86cf-d83bcc67e635	noun	plumas	oõma	1	t	20f04d91-6ad0-4602-ba52-009f191afd21	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
d5f83a89-6458-460d-8b9a-b952ecef5e8a	2d585863-97ad-4543-86cf-d83bcc67e635	noun	guacamayo	ewe	1	t	4cb9fa57-a1e8-4434-b212-20a873060c99	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
a11209c4-7e93-417e-9030-1c418205a561	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	chontaduro	tewe	1	t	c81662f1-9283-4726-855a-8c762144f887	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
f1224e56-68df-4688-a14f-894aeb3c35ed	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	balsa	gamewe	1	t	2c0ca770-dafb-4d4e-bbbc-9525cc35938b	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
08175e20-8003-4c89-a832-af8cc310b946	2d585863-97ad-4543-86cf-d83bcc67e635	action	collares	pantokaye	1	t	c40bc7b4-865e-4586-85bf-a45a320eee98	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
0be4d33b-0e5b-4857-89d7-849ea9e09610	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	shambiras	one	1	t	6531af28-8bac-42c1-8597-046669682d29	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
e7bf409a-598a-4710-942e-a94d94ff7524	2d585863-97ad-4543-86cf-d83bcc67e635	noun	flores	ongai	1	t	2402bedc-0e56-41eb-9369-41b722b1e472	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
d4dbd251-38bf-415e-a219-aa71942d9cea	2d585863-97ad-4543-86cf-d83bcc67e635	noun	plantas	aweyavo	1	t	77278c8b-6b42-4b30-b43e-d58275bb8b33	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
17fbd43d-4079-498b-bdc3-592290dd5a57	2d585863-97ad-4543-86cf-d83bcc67e635	noun	semillas	okatabekaita	1	t	7347efe4-0cad-4c66-8049-3d0605eb4df1	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
2a009856-e854-4747-b4fd-7ccae2fa9a0d	2d585863-97ad-4543-86cf-d83bcc67e635	noun	plantas	ogiwato	2	t	c8b571d4-9b1a-4b65-9026-68e79038afc8	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
a92ab1eb-e425-4eaf-a6d2-244128657a7f	2d585863-97ad-4543-86cf-d83bcc67e635	noun	arbol	wepeta	1	t	7932476a-42e6-4c9c-bb5e-2bce0e8d45d2	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
87688bc1-60ec-4572-a854-d7eeeb38e4fb	2d585863-97ad-4543-86cf-d83bcc67e635	noun	plata	wiñao	1	t	8b9fdd32-e298-4a25-be7b-2ad7905d97c6	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
d95af49b-b2fd-4fc7-abb0-bc4d8d3fc893	2d585863-97ad-4543-86cf-d83bcc67e635	noun	ñashama	wego	1	t	c343851a-8aea-4d71-b6c2-afc6776073c1	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
96206f23-4294-4ded-972f-bc6f12ccadfe	2d585863-97ad-4543-86cf-d83bcc67e635	noun	algodon	kome	1	t	fed5024e-3bab-47a5-864d-008ffe724873	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
ef410fa9-9640-4ea4-a20f-461999e927bf	2d585863-97ad-4543-86cf-d83bcc67e635	noun	falta	ñashama , wego	2	t	4ef6f1ab-2cca-4a09-bdbe-d716183f841b	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
876f2b89-f1a7-4639-837b-6eee64787dc2	2d585863-97ad-4543-86cf-d83bcc67e635	noun	la 	corona	7	t	3ac4f67c-6050-4aca-8d4b-1955f4fbaa32	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
613103e4-75f7-4551-9506-5c5d2d1f4883	2d585863-97ad-4543-86cf-d83bcc67e635	noun	guacamayo  	ewe	1	t	ad277781-5a0f-4822-96c3-1d698cb907d9	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
7e59db10-0d3c-4bd2-b7f0-98cde72a58ba	2d585863-97ad-4543-86cf-d83bcc67e635	noun	arete  	dikago	1	t	fd504d2a-1e96-418e-ba65-3c8cc27ffca0	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
b047e771-9aa2-46cd-83b9-1c284ef73413	2d585863-97ad-4543-86cf-d83bcc67e635	noun	collar  	pantokaye	1	t	198121c9-dbcf-4d89-81ad-d3546ba323e6	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
44c08cf5-ab20-4e20-b14c-74c80d835084	2d585863-97ad-4543-86cf-d83bcc67e635	noun	manillas	onocapome	1	t	e7589e1b-3e02-424b-8d1f-874380434c73	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
4a8716a7-8656-4885-94d6-85097ab4eb69	2d585863-97ad-4543-86cf-d83bcc67e635	noun	coronas	okabogata	1	t	2febfc09-e203-40c8-810c-f34c9283f09c	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
1b4500b4-d761-4fdf-a349-abd7e2489307	2d585863-97ad-4543-86cf-d83bcc67e635	noun	lanzas	tapa	1	t	11c465ca-a956-416f-ac93-7b1c72467446	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
8ce85ef4-929b-4c1a-808f-cefbf21ac269	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	Before	over hundred years	1	t	681c5bf4-3615-4e13-a92f-af1f56b5862b	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
ccca0066-c4d3-4c1d-89ec-bfc0a27882d8	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	spinned 	move the wheel to go around front and behind to produce yarn from cotton	1	t	56085ece-51a6-4349-b26a-50924de3a167	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
c809cebc-e260-4abe-bba2-26a47e474d1f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	jenny 	 the equipment that spinning cotton and building by bamboo or wood	1	t	4426d1b9-075d-409f-ab66-8c017f9d3fdf	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
8c8f01f7-dbd5-417f-af55-8961730e9506	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	strong 	not to break easily when we are weaving and sewing	1	t	38bff362-248a-45cd-b52a-60a98b699446	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
493f6df6-d028-446c-9d3c-c1224b0dc3e1	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	clean	to get  better quality of  cotton	1	t	7fb8c085-7b59-4d18-89c8-0bda6632e850	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
396b4d92-fb41-44bb-9aec-8951517bc2ff	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	rice 	boiled rice with cotton together to be strong and hanging them to dry	1	t	979e5653-3064-48cb-ae1c-2660f1cadeb6	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
df22c358-5379-42ba-acc0-12e6292a8896	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	coconut 	taking out useless cotton powder when they were dry	1	t	b6f72919-bf34-4d79-9f74-fe93117f415e	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
fc1e88b7-a30d-4f0f-b841-9100dce4d830	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	clean	 good enough to weave	2	t	1d9db9ad-27eb-41fc-a597-643b23688fc5	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
d501580e-120f-4f8a-afcd-7f7733f662b8	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	weaved	 we repeated a single yarn by crossing the yarns that  on the loom and  using wood to combine them	1	t	8038f07a-d5ee-42a3-a792-04da75c05354	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
1f7a08a9-07b6-4796-983b-756f1ee2c558	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	loom	wrapping   the  strap loom  around the back	1	t	79169bf0-a4d2-4c8a-bf05-53162560b187	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
d7eb1973-5916-427e-af6b-9a0a5c151fb3	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	years	 the period of the village leader's grand mother	1	t	e0bdc357-378d-40c1-985a-ee0dfc2680ad	2023-03-24 18:03:30.186	2023-03-24 18:03:30.186
219247f8-5d64-4a50-b6a2-16e15fa741fc	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	wheel	building it by bamboo and wood	1	t	458844a9-c8a3-4ac5-9403-5e5df2fb1f33	2023-03-24 18:03:30.186	2023-03-24 18:03:30.186
1a2cb8ec-9d86-4091-94e9-e9fb9138585e	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	fabrics	 it are pieces of woven	1	t	d250d231-c4ee-4665-bb41-f191aa8aae31	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
12827115-248d-40e1-b645-e2fbe16ff36e	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	clothes	to cover our body parts	1	t	c50e14c8-e586-4cf0-97b9-2c9d48708b7d	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
4bb63114-8ef9-4d69-be7d-0da23c54d750	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	dresses	 the cloth is long and straight till under the knees	1	t	2b5b985b-1b3e-469d-bc7b-dadb2bee7049	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
754ccee2-9be8-4531-8e81-66942c65a93f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	yarns	we put through the yarn in a small hole of needle	1	t	68f5bfda-0d42-4445-8778-7eec46eddce9	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
e5d2287b-25a5-4c87-8480-54e6625fd5f8	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	breadth	the sides which left to right	1	t	018c861d-a6cb-4ff1-8254-7ff3d50167aa	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
3829d2c5-cca5-4f13-92a1-75402cc386fb	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	seams	the lines that appear after sewing	1	t	b28e0334-8ed9-46b7-9c20-70a2f5f89051	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
7a00b50a-b382-4082-a1e6-124297d0f196	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	longyi	sew pieces of fabrics into a cylindrical shape wearing and wrapping at the waist	1	t	a1f4f786-e828-4e74-93d1-35b2061ce3f4	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
0b085a5c-17c5-46ff-aafe-e563ac352f0f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	length	the sides which top to bottom	1	t	3f9f696e-8aa8-48cf-96d5-adad5bfe47a5	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
57be3e44-9d05-45a2-82e1-e39e77dc813c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	length	we don't have to join it breadth like longyi  which a cylindrical shape	2	t	f860b432-6a20-431e-b8f5-e8fa790169ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
0e106f2e-80e8-478d-b8dd-d02847cd50d3	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	Before	over hundred years when the period of the village leader’s father and grandmother	1	t	f71a3ec4-b73d-419f-94cc-7c8c6fde74d0	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
a5ce769e-980b-41ac-b040-d875d7d402ad	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	dye	 artificial dyes	1	t	5fb74d30-277d-4c30-8649-2967c9d9dd7d	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
14157b90-8543-4598-9513-8b0e86aacf85	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	dyed	 to create and put on beautiful colours	1	t	12adabeb-cb87-426c-927d-e5cee78b5e25	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
2a0ad09b-20a8-49d3-b21f-cc6343ea6645	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	clothes	 they are making from cotton woven	1	t	1cf28269-94a7-4b24-be60-31f5b0ccfb29	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
a480ceb3-7d54-4eba-94e6-e299b109a8e9	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	trees	slicing their scales or cutting their roots and boiled it in the pot with water	1	t	119365d5-9412-4ed7-8521-beabdc44f032	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
b3f40490-3ea7-4d69-a893-e2958472bf23	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	flower	we could make them to dry all if we want to dye later	1	t	ff3c683a-b0f8-48c6-9e2c-219606bf22aa	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
ddd4cb03-cd2d-4362-975b-036d46dcc88d	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	chose	checking their leaves or flowers or scales or roots	1	t	022c7e21-9076-4182-9fc2-195f2334449d	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
3bc5701d-eeca-4359-8b2a-8706d3b4c2ff	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	wanted	to get the brighter and different colours for our clothes	1	t	15a2b174-51c3-4ea1-bf8b-2b6d0aa1699f	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
cdf9750b-8ebd-4bc5-85ab-d98bd9f56eb1	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	boiling	when the water turn to the colour	1	t	9d878a70-2d3b-4581-a795-2ec8053126b4	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
ce3e37cc-03cc-427c-a69d-0534431c59c6	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	dyes	it did not make by natural things	1	t	84948544-d575-4a20-af13-82d8350e091a	2023-03-24 18:03:30.228	2023-03-24 18:03:30.228
c2980290-892a-4f23-9147-03a73c501d8e	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	generation	inherit from our ancestors and not to be disappearance	2	t	3fcd7a07-21d1-414c-8f90-3bb9cd0a27e9	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
2ebb2df4-7c64-4b36-9f4a-2e267c898f16	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	traditionally	 following to the ways of our society	1	t	cfadf577-5471-4622-99b4-6a3bd2c89126	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
3203b537-e15f-4242-bf45-59cae420d9af	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	religion	the things or statues that we worship and honor	1	t	3fc6c60b-0131-44bf-b361-bf61bf98f85e	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
55654b52-1522-4cba-bb76-d848527bbdcd	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	events	patterning the shapes of the items or ingredients what using in Wrist Tying Ceremony and Fire Festival 	1	t	bf06449b-ea43-4b11-b166-961d8d1e91b1	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
8200003f-e570-4aed-aa0c-cc3e0fcf8916	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	Karen	the largest tribal minority in Myanmar	1	t	96cc8338-6ef7-4c8f-a97a-64a1c083dacf	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
74ddc941-ea31-4d1b-970f-8428d88e7ea8	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	traditional	the largest tribal minority in Myanmar	1	t	caf9d3fa-04f3-4502-9b1d-4cb1c726d930	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
5ca8d448-db97-42ec-ac9c-e7fa80e78c5c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	Ceremony	to call back the spirits and bring good fortune	1	t	010a83cb-2a9f-4454-90a8-63100a2665ed	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
62f290e0-7535-4c00-84e8-ba64a9990a4c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	Festival	worship the pogada where belife  in the heaven with fire bone	1	t	fdcd9cde-5b94-4192-bbe5-77474aac2555	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
0bf10a4c-52fa-45d7-92ff-d72c66fdcd0c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	Pyatho	one of the month in Burmese calendar	1	t	d1a0d060-d435-4fe1-b085-eed03398cfb6	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
89318d29-2eb7-41c4-9179-ded1e47e50c7	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	married	become legal relationship with someone  as their husband and wife	1	t	89e44c50-df88-4321-8f9a-0813c310548e	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
896971f6-df28-4c7c-b4a6-4a132114ea42	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	outfits	wearing two parts of clothe	1	t	cc3ac85e-d0c0-4dab-9808-2f4ffc8ea71c	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
9f7c20d8-3ba0-42b1-b916-35980ce86e4e	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	dress	 the cloth is long and straight till under the knees	1	t	d541b60b-ff25-468e-9f88-d96d09f03c4a	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
e4411fca-ed41-402d-9a6a-24cb432e1b8f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	sarong	 the piece of cloth warp at the waist	1	t	f6dcb6cc-70c2-4cb3-9e14-4fe58b7dbebb	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
406e4e05-7ba3-4a65-84b0-5c3f830b6973	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	longyi	sew the cloth into a cylindrical shape and wearing at the waist	1	t	7b8bbb0f-6f90-40e2-923c-53850735bd69	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
bffe11be-410b-4105-b367-2c5e82c1055c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	unmarried	 they are available and  have chance to choose and find their partner	1	t	b8f0dd2a-a6b7-46b5-ac36-13cdab6f0bd7	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
7c5a75ab-e108-4d4b-90b8-71f5d1c2c3c3	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	dress	 no sarong and longyi	2	t	d4e995ea-be42-47f7-8cb3-24a48a2cc731	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
21042f91-1819-4b05-a79a-c4ce69047ade	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	everywhere	not only in Gone Thar Phaung Village but also outside that the places not this village	1	t	be88b287-86b3-44ed-a923-440ca99736f3	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
a302d868-d775-45dc-9e77-98891edf9f1c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	shirts	no stickers, words and lines	1	t	fa9d3446-a66b-4042-928e-f8c921b3f64e	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
8cc50632-fd68-41b2-a938-b19ec23b6da1	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	plant	growing vegetables and plants	1	t	6bba231b-9cf6-4c1c-bd7b-d5fd209e26f1	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
e165eac1-e4fe-4637-b565-1e00af407eff	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	farm 	the places for planting on the  fields or on the hills	1	t	5ff94939-a0ad-4776-8380-3d676587aa63	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
ec564de1-ea77-4bf1-bca8-d11c51637f52	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	legal	the whole of their community know	1	t	49b97f08-04b2-4414-9da3-f41347b250e2	2023-03-24 18:03:30.286	2023-03-24 18:03:30.286
45aa589c-0dc6-41a4-acfa-95eedde16884	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	longyi	 that's why we can know that they have married or haven't without asking	2	t	a18630fa-c26a-4070-be37-273d1ea7681d	2023-03-24 18:03:30.286	2023-03-24 18:03:30.286
7d4b6459-4792-486d-a8de-7b78c1ed7b8e	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	nattes	en Bulu appelées Obae dont la technique de confection reste bien maîtrisées et a d'ailleurs été vulgarisée sur l'étendue du pays car bien appréciée par d'autres communautés	1	t	c6261a62-e48c-4b7e-9902-35a03cd77787	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
90917fb9-2b14-4932-a92f-426eb5311ff0	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	rotin	corde très solide et très flexible	1	t	52becd72-ba64-4696-a97f-27220b63656d	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
c58870c1-cbc7-4c72-b5b0-f7a572ed0dcc	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	arbre	appelé Engon, choisi pour sa robustesse et du fait de ne pas être attaqué par les charancons	1	t	cf059a1d-af30-4725-b58b-fb26cc94aba8	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
7cdd65e0-2aae-4cb9-80af-45bb95b6b354	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	murs	qui permettaient de voir tous les passants étant simplement assis, de contrôler tous ceux qui pourraient écoutent des conversations secrètes, et de permettre aux femmes et enfants de suivres certaines cérémonies placées le long des fenêtres pour des grands événements comme les dottes, les palabres, les grandes réunions, la salle étant petite pour accueillir toute la communauté	1	t	51d11cde-af9d-4a33-9555-66a89bb14ba9	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
6da25b1e-3f29-4c95-83fa-3be43f96e8c3	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	nattes	qu'on renforçait ou changeait selon le niveau dégradation	2	t	a3cb7eb7-e998-4917-8147-baa03f5098f0	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
fa6beb30-3ebb-40e1-b822-eeffa4092498	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	rotin	préalablement affiné et séché	2	t	5aa342c7-3f63-471a-8a23-15064c48823c	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
72c4248f-2b87-4221-a5ff-8d53179f1636	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	hauteur  	pour avoir une vue globale et contrôler les entrées du village	1	t	e4f6d472-0adc-4254-bd5b-fcf88543bc9f	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
ff88acf6-1d1b-42d5-99d5-88fc86f3a54f	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	charpente	l'artisan du village tenait les rennes, aidé par les autres hommes pour la manoeuvre	1	t	5b58a7f8-9f9a-4ea5-b0a4-62cb8977fdb3	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
3a2ca121-8feb-4056-bd56-4ce69e6ab75e	a016b260-36f6-4535-b20b-ea7af618ffc3	action	tissaient	cette activité était assez facile et presque tout le monde s'y mettait	1	t	1d847c8d-b45c-4705-863c-70714ab97453	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
d96ca47d-d0eb-4111-91fa-52931bb46a19	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	tuiles	cette toiture en feuilles de raphia pouvait tenir jusqu'à 5 à 6 ans, puis était remplacée, mais de temps en temps, on y colmatait les brèches en fonction des dommages d'après tempête	1	t	687a2862-af36-4399-bc59-364a647f4430	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
657dd976-5430-4c57-971f-fd42b43cd3ad	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	général	car l'on retrouve ce même type de construction chez tous les peuples Béti du Cameroun, dispersés dans les Régions du Sud, du Centre, et du Littoral	1	t	5a11c43f-8e18-4d41-b289-c7fb62ec7216	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
7eb9f235-cc47-4fe6-96a4-ff920b768e50	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	écologique	forte disponibilité du bois, du raphia, et du rotin	1	t	6e5daeca-5469-41c7-98b5-56fc58e4ee74	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
f6b12c03-e1a5-4c45-bd7e-cd94aa391c36	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	tradition	connaissances des techniques ancestrales, et des hommes de la forêt que sont les pygmées	1	t	d122638d-9152-4144-98b1-6d21fecca394	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
89c882a6-77db-4d62-8e86-03c7605e8f80	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	colonisation	les bâtiments construits par les colons ont également fortement influencé les formes de nos bâtiments	1	t	257628a7-5126-47e7-a1f7-db236006beb1	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
4b6d54b8-09b7-4d6f-9b1a-192c0dcc9f8a	a016b260-36f6-4535-b20b-ea7af618ffc3	action	origine	à l'arrivée de nos aïeux dans cette forêt, ayant immigrés depuis le Soudan	1	t	46207ac2-64e1-4100-bb3e-01451a6137bb	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
09bfd42e-fc8a-4006-8ff5-5b52d77d4d2f	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	séchés	maisons en terre battue, encore construites de nos jours	1	t	e0b983a7-976e-42b2-9fdd-d3c291c99c2d	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
48f43437-7d92-4e75-a49a-a527d7e846e9	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	marigot	très résistant et très imperméable, qui protégeait les murs en terre battue et pouvait les maintenir jusqu'à 10 ans sans veritables dommages. Nous avons encore des maisons contruites il y a plus de 40 ans, bien debout, et qui n'ont été enduites que 2 à 3 fois depuis leur construction	1	t	d9d5dfa9-e696-4e15-babc-6e122f1cf15c	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
8861b831-1732-4b85-860f-bae130e8877b	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	fermés	ce qui montre le côté privé du local	1	t	a30f2eca-b718-486f-a305-44d080183a3d	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
7ce98204-ce69-4831-ad95-e483b10ded0c	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	étagère	d'un côté du mur qui sert à ranger les marmites	1	t	ae9390be-3415-472c-b77a-99681f452f9d	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
53b8440f-d16c-45e9-9ac3-30442e3ac9b5	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	gibier	et du poisson pêché	1	t	cdf9367e-22b0-4f29-8601-3c95a8f59703	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
ee0a208f-ef14-4672-ade7-08a2592ded94	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	portes 	pour montrer le côté communautaire du local, où chaque membre est libre d'y entrer et sortir à sa guise	2	t	3c7ebfe5-992b-41c5-a25b-7dca2a5932f4	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
206929e4-d43c-4279-a680-e358ddc13fc6	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	communautaires 	communément appelés Foyers traditionnels au Cameroun	1	t	63e23e16-b508-4b6c-bd4f-52d727cb0904	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
4337a1e7-aa2a-4746-b9c0-b3c8efe45c3f	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	ABA	appellation en langue Bulu, différent de l'ABA-NDA qui est le séjour d'une maison qui était réservé aux hommes	1	t	61e8ce78-ecf0-4ae9-bc3d-5fb1ed8b0705	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
99ddb77e-6616-4023-abcd-6bf2b487b011	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	main	car c'était des travaux difficiles, et ils étaient assistés par les jeunes pour l'apprentissage et la transmission des techniques	1	t	78af2656-3147-4926-85c0-44c52f1741a7	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
41e43f0a-eb5c-4d74-b682-4e24a3379809	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	rotin 	(des matériaux qu'on retrouvait abondamment dans notre forêt, et qui fort heureusement existent encore en grande quantité, malgré la déforestation	1	t	b3361b72-55e0-44f4-9b5f-0c50f859ea9d	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
eab667fe-d2d5-48f9-8a56-9bc41ba11f76	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	rectangle	pour constituer l'ossature du bâtiment	1	t	7db6e3a8-02bd-4995-8ae9-3e05a42e1243	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
b50c14f3-6361-4f48-b7b5-8902090a7b15	2d585863-97ad-4543-86cf-d83bcc67e635	noun	materiales 	tronco ,pambil,bejuco,hoja de ungurahua	1	t	0629f94f-a54a-4bdd-989a-8e47dc034290	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
e6176388-e3ca-4c3a-8e03-64ffb12c5581	2d585863-97ad-4543-86cf-d83bcc67e635	action	recogían	salen  de mañanita en busca de materiales solo los bases principales	1	t	ac59c1d7-036d-489c-93f2-90b38f0d1c7c	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
58604ff9-6b90-4325-b716-781b16290366	2d585863-97ad-4543-86cf-d83bcc67e635	noun	selva 	monte donde hay diferentes arboles	1	t	fc8708e1-cb96-4d93-bc98-ec624ce6216c	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
aca5d438-0b8c-4a95-9e99-c499d107f17b	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	montañosas	lomas altas de yasuni	1	t	08fe6d7e-eac2-4543-9fa7-ada2b0aecc2b	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
fbe7cd7d-668e-4b27-94e1-29ffb3b11601	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	nativas	tierra ancestral	1	t	3cec35a1-26b4-4a80-b232-d519157c5cb3	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
c74f488a-d191-489f-8479-84379b3a170e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	techo	hojas de ungurahua	1	t	256c5a6b-6853-4998-9b21-9e7374982d58	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
128fab88-6135-4237-980d-0873c1d79bc4	2d585863-97ad-4543-86cf-d83bcc67e635	action	usavan	de proteccion contar las lluvias colocan encima de casa	1	t	1b0a9a67-2928-4c6d-9a2e-fc32404c4672	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
232b64ab-17e3-4ea0-9b0b-4ebe917c5999	2d585863-97ad-4543-86cf-d83bcc67e635	action	hechas	a mano  de  los hombres	1	t	69e9495d-fd65-4462-b8cc-b081ffff133f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
a55d7e8e-3f37-4f43-b962-0414119d839e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	Pajadetoquilla	 planta de ungurahua 	1	t	a9984f67-f393-4101-a157-905837b1e4a0	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
8fc5dc31-55cb-4ee2-bc36-3d965b5b6dfa	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	amarados	en tipo cruz se amaran	1	t	1dce75c3-b9d4-4ec3-a6fe-573d51ddb51e	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
36c2f335-8d82-47d6-bf9c-ba83c15ece56	2d585863-97ad-4543-86cf-d83bcc67e635	noun	panbil  	orisontal y vertical para que no se pueda mover	1	t	fa669bd7-ae91-4e96-bd49-a247e554cf8f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
9dfb2ff0-606f-4ac9-aca0-713790fba09d	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	resistentes	bejuco traido de monte	1	t	50a60b57-5f18-49e4-8630-a4ac1a8fb970	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
982a547c-2bd6-484a-bf41-7ead9ff425f5	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	rompiéndose	solo se consiguen de los arboles	1	t	dc587a1b-2e82-4c6a-b9de-c4209d9c4234	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
341cd82d-9d47-4f30-97a0-59cd843e7acf	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	grande	arbol largos y de altura alto	1	t	65ae9980-ab81-4b46-99e6-6ae204940ec0	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
467279df-667b-4850-901b-d8ce221214ca	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	nativo	tierra ancestral de nuestro antepadados	1	t	858b1501-5bb9-44f8-8e7d-1dbb275cd173	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
a853117f-c434-429f-a58a-3a76718968d0	2d585863-97ad-4543-86cf-d83bcc67e635	noun	tiras	son partidadas de pambil como tiras	1	t	d0cb512a-06d0-40fd-a234-c1795e655ccd	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
5999a2a2-9fbb-4a02-9b6d-d03c7202cd68	2d585863-97ad-4543-86cf-d83bcc67e635	noun	panbil 	de chonta duro	2	t	ae6ee06a-7559-4c81-9192-997d3be5d5c6	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
4cd5430b-89da-4114-889e-e594252c2721	2d585863-97ad-4543-86cf-d83bcc67e635	noun	befucos	amarar dos veses crusados para mayor resistencia y para que no desnivele del lugar	1	t	4610c169-70ab-4f52-8b26-689d07641d77	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
e3b68390-71f6-42a1-a90a-28784b1f3e3a	2d585863-97ad-4543-86cf-d83bcc67e635	noun	tierra	el piso caban con pala pequeña despues prenden juego para que con el calor de candela seque el lugar nivelado cada ves baren para que el polvo no se eleve	1	t	0853c814-4523-4799-8d3e-64c0a80c0d39	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
81b7d059-6b70-421d-a384-fa2b65a2e9f5	2d585863-97ad-4543-86cf-d83bcc67e635	noun	hombres	todos trabajan para ver el mejor resultado	1	t	c5ab93a9-a696-4c50-b2eb-282da1c99eda	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
c9a557b8-5c6a-488e-83d6-046689ed252c	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	tipica	construciones de casa costumbres	1	t	96f4513d-6ac9-480e-b7cb-589e71b251be	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
e49b6edd-51cd-45c8-b55a-374c03075376	2d585863-97ad-4543-86cf-d83bcc67e635	noun	waorani	huaorani. adj. Dicho de una persona: De un pueblo  que habita en la Amazonia  ecuatoriana.todo lo que es parque nacional yasuni	1	t	09c44d95-d00a-4c73-99bd-d95a6c0b6306	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
d776b365-4df1-4efe-b3ab-d56a2c597d12	2d585863-97ad-4543-86cf-d83bcc67e635	action	buscan	ver un lugar bueno allar lugar plano	1	t	0ba66866-9ea7-45e2-a9b7-a130d096e828	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
1d4ad743-4854-4bb6-826d-22e83728abee	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	grandes	refiero arboles de tamaño de 2 metros cubico de altura 14 metros	1	t	72d63f72-aa7e-464d-9ab7-c5222d48ede6	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
65dae5ef-3ddb-473a-9c93-4b7531fc47c3	2d585863-97ad-4543-86cf-d83bcc67e635	noun	inundaciones	problemas por crecimiento de agua en rio  que llega a peru	1	t	95a0a549-ffb6-426d-ba4e-b79f6ebbfcac	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
3a9e6f8d-57d3-448b-bf12-e190ca6f0907	2d585863-97ad-4543-86cf-d83bcc67e635	noun	río	Corriente natural de agua que fluye permanentemente y va a desembocar en otra, en un rio o en el mar	1	t	632f0b0a-ac8a-4906-b4f3-b3ad9fcb6cf2	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
4128fbbd-8977-4d28-a964-69ff5f77ff36	2d585863-97ad-4543-86cf-d83bcc67e635	noun	arquitectos	Persona que se dedica a la construcion de casa	1	t	f9098170-5066-400f-adbc-312747fa26b7	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
80161db1-63bb-4388-951b-e67c32f63857	2d585863-97ad-4543-86cf-d83bcc67e635	action	ubicar 	Situar algo o a alguien en un espacio o lugar	1	t	18464ec9-eff8-4752-8397-a13e9732855e	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
be3dac32-8bc0-422b-be19-8ec99eb92fc0	2d585863-97ad-4543-86cf-d83bcc67e635	noun	viento 	Corriente de aire que se produce en la atmósfera al variar la presión en la amazonia	1	t	2e6e4645-f2ca-4f2d-b09b-adfdebeb1aff	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
4f0a32a3-c8c5-4058-8ec3-3629afdf810a	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	fuertes	Que resiste el uso continuado, que está firmemente sujeto y es difícil de arrancar, quitar o romper	1	t	771381ae-8309-4c50-b54a-00222915272d	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
b8f69d86-70fa-49cf-8809-01ed70521985	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	suaves	Que es liso y blando al tacto	1	t	2ce06bf8-316f-4e64-b6ed-4c9516a7bebe	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
b42e2943-e6bd-4dff-86cf-c5e57526114f	2d585863-97ad-4543-86cf-d83bcc67e635	action	parar 	(Dejar una persona o una cosa de moverse o de avanzar	1	t	3d7cf1c2-d788-4094-8ea6-381956c23bf8	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
e2c0725a-80ff-4c57-9adc-beb23ba096fc	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	extraídos	sacar ,//poner algo fuera de donde estaba	1	t	7158dbb7-12cf-4a22-87c5-508b43c7e72e	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
6b9b5e68-63c3-4c83-a9ab-890e6e81bfd7	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	necesarios 	Que debe ocurrir, hacerse, existir o tenerse para la existencia, la actividad o el correcto estado o funcionamiento de alguien o algo	1	t	8cfdbaac-1883-4246-8bf0-279fc353ee6b	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
a6e5d754-bedd-4244-85b1-942e38f44704	2d585863-97ad-4543-86cf-d83bcc67e635	action	ponen 	añadir, poner, agregar, sumar, echar, adjuntar	1	t	dbef1447-ea68-46d7-bdec-40b014801730	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
b5bbf470-b4bd-4782-9c10-11649ef35c0e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	vigas	Elemento arquitectónico rígido, generalmente horizontal, proyectado para soportar y transmitir las cargas transversales a que está sometido hacia los elementos de apoyo	1	t	fe2f86a0-8176-4582-88cb-09c149ad431d	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
9a346a4d-ddc6-450b-a2f2-2109bbf443a9	2d585863-97ad-4543-86cf-d83bcc67e635	action	tigeras	tiras de maderas donde se ponen las hojas de pajatoquilla	1	t	1cb3249a-581f-493f-8ce7-c9df752b49a8	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
6aeccb56-a7ee-47e2-9371-1b3778becb37	2d585863-97ad-4543-86cf-d83bcc67e635	noun	ungurahua	hoja de una planta que se usa para cubrir como techo para proteccion de las lluvias.	1	t	fdede15f-7823-4e71-b769-b074620d7c3f	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
79b7f7e2-10f8-4904-80f9-70935c09aea1	2d585863-97ad-4543-86cf-d83bcc67e635	noun	material	hojas de ungurahua	1	t	6ce6904d-2cdb-4833-a59a-6105e3fbe0a8	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
0b5be856-103f-4e3c-8623-31b75ab79388	2d585863-97ad-4543-86cf-d83bcc67e635	noun	techo	Cubierta de hojas de ungurahua : techo de palma	1	t	1180ae91-c59a-4bba-8664-c2327dfda327	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
8c71c46b-3b82-43ad-b3b2-1c06b3e3ab0c	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	real	Que tiene existencia verdadera y efectiva	1	t	95f3d5e6-b00f-4b7e-a252-bbb62ab2b0b4	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
bf788c97-154f-4a63-a83c-b216f16bb468	2d585863-97ad-4543-86cf-d83bcc67e635	action	manteniendo	mantener, tener, mantenerse, seguir, guardar, conservar	1	t	68d88b17-3065-4b61-b467-a494f0c54439	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
94c71f6b-06eb-4ded-b413-118b7c147a30	2d585863-97ad-4543-86cf-d83bcc67e635	noun	herencia	herencia que los abuelos an enseñado a hacer costruciones	1	t	5eab1452-2e4c-4734-ba80-6e7e95622eaa	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
aceae62f-077c-4902-9ad5-e921da305f57	2d585863-97ad-4543-86cf-d83bcc67e635	action	contacto	inicio del año que fueron contactado el pueblo waorani con personas de la ciudad	1	t	d4ab6b09-5914-4a45-a48d-47dc9bac05b1	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
0337e75a-27de-4d2c-a52f-aca540c04ed3	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	occidental	personas de la ciudad que venian , estranjeras de EE.UU	1	t	fdf2bb22-99a7-4165-b04d-6a59ff8ededc	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
7d289558-1f35-4734-889f-3165766b61b7	2d585863-97ad-4543-86cf-d83bcc67e635	context	lugares 	barrios comunidades waorani 	1	t	9e2ce002-d85e-4d98-9df2-cd81d6cf8071	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
ef64387f-3995-498f-bb77-fd79c4f09c0e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	nueva 	forma facil de construcion	1	t	10ae0374-6849-44d6-a5d4-62c43da7f71a	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
e4161297-c0f2-465a-ad7c-b882638622a1	2d585863-97ad-4543-86cf-d83bcc67e635	action	conocimiento	hacer contruciones con material de ciudad no usando de selva	1	t	c333fc33-2a5f-4036-96a2-cd03a1d4466a	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
d47f5bdf-0408-4377-8960-4151da16dac2	2d585863-97ad-4543-86cf-d83bcc67e635	noun	modelos	 diferente forma de casas hechos con material de ciudad	1	t	8e56a165-06e9-4b07-9144-450daa8c42ca	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
ee2f107e-85cf-4bac-b14f-a6f3ee94b5f9	2d585863-97ad-4543-86cf-d83bcc67e635	noun	tipica 	 construciones a constumbres	3	t	42d4d81a-63ba-4c03-a7a0-4f9f861dd99a	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
908059b7-d304-47d5-9abf-fd3a7376f924	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	huarani	huaorani. adj. Dicho de unas personas: De un pueblo  que habita en la Amazonia  ecuatoriana.todo lo que es parque nacional yasuni.	1	t	fefeb973-77cf-4423-882f-cd3fbdc2e924	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
f32d4140-8ea6-4e4f-9e51-9916561b7a33	2d585863-97ad-4543-86cf-d83bcc67e635	noun	modelos 	una forma de cosntrucion de casas unicos en tribu waorani	2	t	4935dab0-204d-46a2-ba8a-cb3226044dcf	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
3bde46ff-0f92-4cbe-a758-0076e87c0ebf	2d585863-97ad-4543-86cf-d83bcc67e635	noun	cultura	costumbres de ante pasados	1	t	a1e22a68-a26d-4ad3-9fde-113198ab2058	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
5381da58-e6a6-4a45-bfa7-72b1d667bd85	2d585863-97ad-4543-86cf-d83bcc67e635	noun	tradiciones	tradicion la forma en que vestimos o hacemos y vivimos	1	t	3d2f7fab-b79e-410a-922b-5380ae9b916b	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
0c796e54-8429-408d-a245-ac5032c64c21	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	diferencia	forma distinto de cosntrucion	1	t	fc01eef1-27a2-4e3d-885e-090f87470666	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
c6f961af-5f1a-410b-a514-994548f7ee0e	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	cálidad	plantas de arboles buenos que durar por años unos 5 años	1	t	55195276-f1d8-4d84-aee4-f9f57e035c80	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
3d4b1857-b1a8-4603-95d0-7acf6c1f47ea	2d585863-97ad-4543-86cf-d83bcc67e635	action	amarados	con piolas de bejuco	1	t	3d628af5-6536-49d6-9b33-73d544b8248c	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
46193b43-2d22-4292-a155-f0015e3f44ed	2d585863-97ad-4543-86cf-d83bcc67e635	noun	paredes	 es para proteccion de algunos animales y mosquitos y esta hecho de paja de ungurahua y pambil ,es traido de selva los material ...	1	t	756a93b6-da40-4616-adca-66f7580764a1	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
6b57224e-865f-46b7-b22c-f3ddc6ad90f5	2d585863-97ad-4543-86cf-d83bcc67e635	noun	amarados	dos ojetos apegado y con piola se da vuelta para que no se safe	2	t	b947b10e-43dd-447d-987c-13c55d53f940	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
13067af5-ed3c-428c-bf75-8fe6a9a859d8	2d585863-97ad-4543-86cf-d83bcc67e635	noun	befucos	una material que es para amare para protecion de desganche	1	t	2c1ccd5e-6838-457b-b1cd-eb12227e18dc	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
4887ccc4-2326-44d4-9a5b-5001d6445839	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	resistencia	una piola que no se rompe por si sola	1	t	4d28cb46-2352-4fec-95f4-09e6ec5f53aa	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
66483832-658c-409e-a7e9-35f3a6188701	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	dentro	 lugar de descanso	1	t	3c0a1b40-0a86-4278-867a-3c5b275e7b7c	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
528a32e5-812b-43c2-929a-9088168d91ae	2d585863-97ad-4543-86cf-d83bcc67e635	noun	amaca	 ojeto que sirve para descansar ,esta hecha de piolas de shambira , shabira traida en selva	1	t	1a178c5f-57c0-4674-ad7e-1561543162bd	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
bb4d3dc2-5cab-4b48-a587-4ac0d425e7ca	2d585863-97ad-4543-86cf-d83bcc67e635	action	dormir 	descansar en la noche en la amaca	1	t	bf5eaaf3-c467-407d-9013-e8df66fa9b77	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
e75f2cc0-d4eb-473e-be93-2785ada8bca3	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	alado 	vajo los pies unos 5 cetimetro	1	t	fd71459d-f6f7-4531-ac67-034e8564bd74	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
fbdd4568-50b3-4147-8f8a-fc0b0a18108e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	leñas 	palos secos para usar en juego	1	t	486c030c-9ffc-4b87-89b1-70495bf1db01	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
683d0f9f-c5b4-4211-806f-fde906c837b1	2d585863-97ad-4543-86cf-d83bcc67e635	noun	candela 	(juego en llamas candela 	1	t	744b4f23-6db5-4392-a742-e38c8e2b8854	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
2dda0307-bfbe-42bc-940b-d93a8d59d6ba	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	calor 	 con el juego tienen calor en su cuerpo	1	t	ea08291c-4e80-4b39-9807-05543be44bff	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
cff5eef7-941a-408b-a4b6-85567d51606e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	noche 	 lugar oscuro en nocheser	1	t	bde1d9b9-6a6b-423c-a13f-880eeefb0127	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
f5bcc0d4-b054-4785-9eaa-e0f6549f5f24	2d585863-97ad-4543-86cf-d83bcc67e635	context	tejado 	un lugar donde	1	t	31177dcd-9485-43e7-a950-09050bdcf155	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
7a26c691-d9f6-46f5-8ce4-7ead11491a85	2d585863-97ad-4543-86cf-d83bcc67e635	noun	lanzas 	arma poderosa del trobu waorani ,esta hecha de pambil de chonta duro	1	t	64ac0d8f-9049-4e51-a4d5-b320c1d9e15e	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
a57b7adf-7286-4496-858f-8b1707fbe9a0	2d585863-97ad-4543-86cf-d83bcc67e635	noun	dueño	propitatio la persona que iso la lanza	1	t	37e96c24-d127-4f14-9935-d1d8b330dd13	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
1ec97668-b174-4445-ba2a-74426ee1ae10	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	cubierta 	protegida	1	t	4a44f42d-6894-4ce6-8924-c32e5c760445	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
10bfcf98-05b7-4e82-b7b9-85c01bb29f46	2d585863-97ad-4543-86cf-d83bcc67e635	noun	ungurahua 	una planta que tiene ungurahua y que tiene hojas largas para construccion	3	t	091e513e-cd1e-4d1a-994a-2cf5bedda1f9	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
94a8fe3f-d321-4374-90dd-9dfc4ae7436a	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	tipica	durani oco ; casa cultural 	1	t	b243f6aa-1f19-44c1-9b8e-5e10a3971a34	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
58411f97-314c-4ee5-8bdb-105cb547848c	2d585863-97ad-4543-86cf-d83bcc67e635	noun	troncos	de pabil -tepa traido de montaña a 1km 78mtros de distancia	1	t	2928ef71-db2f-4abe-a346-f3b9f421f2e2	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
027b05c2-0246-4434-8b0e-8dcecd4367af	2d585863-97ad-4543-86cf-d83bcc67e635	noun	panbil	tepabi ; traido de montañas	1	t	ce120375-980c-4eba-aad7-41a114a54053	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
3d977ee5-e627-4f8e-bcfd-92ccb6747c79	2d585863-97ad-4543-86cf-d83bcc67e635	noun	piolas	de bejuco ; otome-orocame traido de selva unos 3 km 800metros de distacia ,consiguen en los grandes arboles  como no moderables y en ceibos	1	t	68db6a2a-5677-4a07-a7f8-671aae47ca95	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
68c3e348-20b8-4255-83d1-10382f3e230d	2d585863-97ad-4543-86cf-d83bcc67e635	noun	Pajadetoquilla 	oma .traido de montaña a 2km 40 metros de distancia	1	t	b2fd9f2b-56fe-4ec1-a377-f033d189b14a	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
d19904b3-31d4-484e-ad36-435914dbda7e	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	leaves	dipterocarpus tuberculatus dry leaves	1	t	52f86fc4-c115-4244-8490-876df30b350d	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
5491bf20-114c-4f10-b8b3-288c578d2fec	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	bamboo	making long cylindrical bamboo in to a slab or slicing the woods and bamboo in to long rectangle pieces by knife and saw	2	t	ef3efb74-62ed-4f66-975c-205610768b10	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
f709516d-dcf1-477f-ac6a-5bb432c7d162	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	leaves	only in fall, winter and spring because the leaves were not dry in the raining season and it didn't fell down a lot under their trees	2	t	eb800019-d181-479a-9a92-5fa02fddd480	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
e6587b93-e5df-4c02-bbd0-e79aafd5d74d	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	rose	we had to go and woke up earlier than other people because there was nothing and wouldn't get good leaves if we were late	1	t	a5b9eb88-8faf-430f-8dca-16c8d3413601	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
8e5015d4-3fa8-453a-b053-b711099cd1c5	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	method	moonless and after full moon are good times and we don't use this tree anymore if we hear the voice that like snack's whistle when the tree fall down on the ground	1	t	3f4a9752-e416-4d7a-b183-45d7308830ce	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
09d82988-30f9-4466-9a6c-3526ec171622	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	leaves	the widest and thickest leaves among the leaves in our region and we don't usually other leaves	2	t	d23ca3f5-c47b-4fff-9781-ca8737857a20	2023-03-24 18:03:30.651	2023-03-24 18:03:30.651
630d6e35-0fd3-4fc7-9cec-af536ef32c70	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	foundation	digging the holes on the ground, put in bamboo or wood poles in there and we recovered the holes tightly with the grounds what we have digged	1	t	e71d9b25-b8f9-496d-92f2-9b896c018f6f	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
f06f3bea-31ac-4c10-996a-71d08d2082ac	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	raffias	sliced the bamboo till they were thin and soft	1	t	3b88de31-bd4f-4707-b252-7cd1b2697539	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
54019680-fb6e-4ec5-a906-d696c72a3a6a	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	trees	we found and cut liana in the forest and near mountains or we sliced some tree's scale by knife and twisted them like a rope	1	t	c4d483cf-88e9-47c0-98ba-800b3bb52a2e	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
3475f07b-1e84-48ff-b14e-b1628391417a	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	soft	[to tie easily and comfortably like a rope and if we wanted to use them to tie other things after slicing, we had to put them in the water because it became strong like a stick and it would break easy during we were tying	1	t	657cafe9-435b-42f6-b691-6fd92436df69	2023-03-24 18:03:30.668	2023-03-24 18:03:30.668
d83baf5c-fec9-4eb7-8e24-76ca017f27be	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	measured	using stick what marked by cubit before we have measuring tape	1	t	66b92687-6e1e-474d-9b08-66455fbaa1b9	2023-03-24 18:03:30.686	2023-03-24 18:03:30.686
f57c22ab-9fdc-4330-a45a-7471d72fc99d	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	methods	for worship place has to have on eastern and southern. Letter has to have only western and northern and every the step of letter have to finish with odd numbers if we don't do and follow it , we will not be wealthy and bad things will be effect our business, health and households	1	t	5b307dde-597d-43d9-8e5d-25bddda4bfdb	2023-03-24 18:03:30.686	2023-03-24 18:03:30.686
38e038aa-3fdc-41c9-821f-b8cea3e630b7	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	cubit	the length that from the top of middle finger to elbow	1	t	0f9c2a47-512c-4cf0-896b-ea3ef3b4f42a	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
c7a1bd4c-b490-4e41-ad02-5b278d3d4f38	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	place	when we sleep, the sides that we keep our head	1	t	eca4c491-4880-435d-b229-1cd916d0e1d2	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
fcddd7a6-f22a-464e-a2f8-1cf741dbbcb7	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	odd	we can finish at 1or 3 or 5 steps,ect.....for a letter	1	t	480cf7e1-3bb6-45ce-ab7d-fa67b5644412	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
3e8f98f7-ca54-4c4a-af4f-cc0c416ed357	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	bricks	digged the ground, mixed it with water and  put it in  the  shapes of rectangle cups . After that , arranged and dried them in the sunlight and baked them with fire	1	t	89fe3bb9-bd7f-4652-98d9-81a60fdd4131	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
e17a402d-ecf5-4090-a662-1da6ad350e53	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	stones	 buying  gravel stone from the shops near the river and we buy lime stone from mining places	1	t	c046a891-6393-4946-b8c5-c95658b28c33	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
5f655b35-9cb7-46cf-8a99-20358c8713df	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	stones	bought from the people who could find it. They carved them by knife in to square and made the hole on the tope of square to put in the pole and to protect termites eating the poles	2	t	24512dc5-b061-48cf-b8cb-883c7d659731	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
7aec8828-e8ef-4add-972b-235c843251a2	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	water	squeezed and pressed to be sticky and strong	1	t	1db2ebf4-6d34-4258-97cd-ccc8e1de39c6	2023-03-24 18:03:30.71	2023-03-24 18:03:30.71
25fd1b19-403e-4fbc-9e27-cf54d3d1a40a	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	building	constructed by cement, concrete brick, stone, steel, and zinc roof	1	t	cc669e6f-d92a-4e0b-997f-0371ad8c30a4	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
ed896368-5f4b-40c7-b8e4-fc1a87050bbd	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	natural	used the things that got from nature and constructed them by ancestor methods	1	t	42e8d08c-5e50-4e6f-bdb6-0c695239cd3c	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
7e3fa826-b42d-46ae-a0b4-b81178c88e39	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	healthier	they maintain the temperature depend on the weather and there are no disadvantages, comfortable and peaceful because it are natural things	1	t	3d2f7c9e-8658-40e9-8a5c-d2cedd078c77	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
64033b5f-3f63-4c25-be3b-ad0b6849ceac	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	community	not only in Gone Thar Phaung Village but also the villages that around in Kayin State even Thailand- Myanmar's border where Karen people who live in refugee camps	1	t	b5959da4-b8e2-4576-be99-dcab1fbd2700	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
6a3f51e7-ce4d-4e2c-8c9d-b5ce438d0431	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	concrete	mixing the cement, gravel stone and water, sand together by measurement	1	t	8fe5827f-3c92-4d59-84af-2c471cde042d	2023-03-24 18:03:30.726	2023-03-24 18:03:30.726
dd703cd8-abbc-401b-8231-96b7b8bd2f7b	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	nature	woods,bamboo and leaves	1	t	1996b239-87db-45fb-a18d-5d4754a68788	2023-03-24 18:03:30.726	2023-03-24 18:03:30.726
a3f57437-7c92-49a7-9e06-e1e550788ca0	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	transport	terrestre, maritime et astral	1	t	334b1ac8-06c0-4061-aed7-441978d040fb	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
9e706843-948d-4f89-994a-d32c16cf767b	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	hottes	pour porter du bois de chauffe, les produits des champs, des marchandises, des bébés	1	t	e09c8072-6950-4225-ab5c-c4546e8ac084	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
df37ac85-cc40-4513-bc2b-4516464fce8c	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	dos	construits selon la technique en spirale ou la technique du nattage avec le rotin filé. Ils sont souvent terminés par des bords plus fins	2	t	f01957ec-5b41-4dd1-a25e-73d82a4b983c	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
43cbcacf-a041-4098-b31c-3b661fb65859	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	rame	construites à base des troncs d’arbres abattus en forêt	1	t	031e12ee-d357-4274-8772-f76857c55f99	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
2a68bba8-74a1-4e30-bf60-8600a6b496fc	a016b260-36f6-4535-b20b-ea7af618ffc3	action	téléportation	pour voyager ou transporter un objet sans, physiquement, passer d'un point à l'autre	1	t	04d6341b-119f-457d-8135-def24bcf56be	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
bfd4ed92-d7bc-461f-8e4d-26ef2cfba7cf	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	géographie	contournement ou franchissement d'obstacles naturels	1	t	d6a04b48-12ca-4dc7-9c06-42f0ff9b89a0	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
e473ff93-30a9-468c-9eb4-588b76457798	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	gens	hommes et/ou femmes	1	t	55f98b74-57db-4af1-9955-0aadd7fb817e	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
a67a4225-044b-4933-976a-c835d3c81930	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	transport	pistes rurales, montagnes, marécages, rivières...	2	t	22a5cf84-96bb-41e1-8f60-3c05f2f8c357	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
352332ac-9bf9-4ebf-a9ec-79bcc0a6e3d9	a016b260-36f6-4535-b20b-ea7af618ffc3	action	travaux	défrichage, trouaison, piquetage, semis, récolte	1	t	c59f0e8a-75d6-4d3b-9545-95666ff9234c	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
aa52e1f7-d94e-48a8-a390-b1506f686eaf	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	essences	forestières	1	t	d943c4c2-1582-4884-9be3-03a97ba09412	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
475a5598-8a47-4a29-9e39-42294caa8c34	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	ligneuses	bois de chauffe, bois d’œuvre	1	t	6b1b5da5-08f5-4bb8-8208-b9ecc8339333	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
bb15e634-27a5-4195-b19c-11bb2b37f511	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	ligneuses	incluent une multiplicité de biens autres que le bois, dérivés des forêts, comme les aliments, plantes médicinales, épices, résines, gommes, latex, etc.	2	t	44122e6b-97d6-46d9-b327-235706bb41ea	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
0ce25c5e-4a88-48a2-8185-78e463827cd9	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	commerce 	de vivres	1	t	a89f0336-a5cb-425b-8060-7107955d2913	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
1c5931f2-701f-45c9-907e-90ca7434a8f4	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	heureux	dot, mariage, naissance, rites traditionnelles	1	t	6e321cf3-d54f-4adf-be85-a51cc87cde41	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
ebaa7653-76b9-4bd3-9d74-4d1ba94482f9	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	malheureux	obsèques, maladies, etc.	1	t	2e5e3146-20b0-4cc1-8a03-4636ea2b05da	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
68193e75-01e5-4202-a116-f0ff1c5c4565	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	hottes	(pour le transport des personnes et des biens des champs	1	t	286add80-ab83-41de-a0fe-7426013a1ebc	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
1a6f61fd-7548-4a9f-9c6f-a680836abaa7	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	animale	pour alléger les charges, gagner en temps et réduire la fatigue	1	t	f9215910-7688-4dbf-8c3c-cade5e2fea85	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
882a4c79-8966-49ff-94f9-9b2e3cb874c1	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	moteur	qui a réduit les longues distances, le temps de transport et la fatigue endurée	1	t	b86ec8d0-ada8-4a27-a26e-96e43d11c1cb	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
f45677e7-3a3d-4ee4-a91b-961ddf8f1cc1	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	initiés	de la coutume et de la tradition	1	t	0c6b2ec6-77de-4f31-b5eb-06b54638ef71	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
c80eb7ea-ac0c-413a-866a-1b965c02605a	a016b260-36f6-4535-b20b-ea7af618ffc3	action	accompagner	lors des déplacements à longues distances	1	t	ed7402e5-2c02-4ee9-954c-607d4361cbba	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
9785118a-4ec3-494a-bb96-a0e6489f74c1	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	dos	les transporteurs enfilaient alors les bras à travers chaque corde pour les loger aux épaules, et porter la hotte au dos	1	t	a9be8c2f-2bad-425d-a1ea-7f6a929537a7	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
8441f4f6-83aa-4661-ba91-d845dd1596f4	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	pieds	pour ramer la pirogue et suivre le courant d’eau	1	t	cbc632cd-7baf-4e8a-9af3-a151a8de117e	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
1bcc9267-cb16-4358-bf4a-bf4746e8a19a	a016b260-36f6-4535-b20b-ea7af618ffc3	action	invoquaient 	à travers des rites traditionnels réservés aux initiés	1	t	fff4872d-eb52-47aa-a137-5c6d221ddcbe	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
0ab0a37c-09c3-45f5-9260-09b37d65b0bc	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	endurant 	compte tenu des longues distances et des charges à transporter	1	t	dcd7200f-8e0f-4e10-9555-244a9279b981	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
2e8bfa73-a240-4d59-bd61-d6917cd82598	a016b260-36f6-4535-b20b-ea7af618ffc3	action	intensifiés	grâce à l'invention du véhicule de la voiture, pirogue à moteur et d’autres moyens de locomotions de plus en plus accessibles et rapides, le boom démographique, l'accroissement du niveau de vie, et aussi par la construction d'infrastructures routières	1	t	54424168-1bf3-4b08-b0e4-7871cc3656dd	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
fa3b568d-98b9-4c0a-8241-eb9f735c3dc9	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	champs	qui sont le plus souvent très éloignés dans la brousse	1	t	c4c7c8b2-4844-49fe-bd93-944f66127f88	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
c2b745b7-43d3-44e8-a031-914ec522dc9b	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	enfants	lors des déplacements d'un village à un autre passant par les pistes de la forêt	1	t	488ccf99-9cd4-41d8-8b4b-6e114bdc300c	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
3c4cc04b-905e-4f4a-bed4-b29b8f3733f2	a016b260-36f6-4535-b20b-ea7af618ffc3	action	déplacements	à travers notre grande forêt équatoriale très dense	1	t	e930b1b8-e2ed-4191-9dde-ffcf4839d63a	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
5af4b4ea-7234-4b14-8f2d-5696a9503773	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	lourdes	bois d’œuvre, gibiers, récoltes, etc.	1	t	01bffbde-667e-40fe-84bc-e45f74975ba4	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
6b077450-f2e2-4a3b-948e-5cbd464bb305	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	traditionnelle	qui malheureusement ne l'utilisent plus ouvertement de peur d'être taxées de sorciers par la communauté	1	t	7f3a7b8a-6d5f-4678-941d-9cd2566e4f31	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
ee5ad2cf-bba4-4af4-878a-53e8f1b27676	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	muchos	unos 60 años atras	1	t	1f12bcf8-a24b-4e09-8c2f-43fe928fc98a	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
27d42c34-50d0-45f7-b24e-c81f2dff6235	2d585863-97ad-4543-86cf-d83bcc67e635	context	montañas	de amazonia y reciente nombrado yasuni	1	t	5bd8a380-954b-4535-b7ef-1123f4645fad	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
3c51137f-68cb-4a53-b3db-2b7d3550eb2e	2d585863-97ad-4543-86cf-d83bcc67e635	noun	transporte	un ojepto donde puedan viejar	1	t	d9837034-f12e-482d-8279-d87f9ffd3e45	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
0b2af1be-e816-4415-9ed3-0096d48ef779	2d585863-97ad-4543-86cf-d83bcc67e635	noun	canoa	una lancha que flota en agua	1	t	6da18447-eee2-4b30-9641-56aafbacee7a	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
61a3d1a0-97db-4fe7-af8a-b8ce74eb3ada	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	cedro	 un arbol maderable que asen que se convierte en lancha	1	t	c61f49e1-bb7f-4b2c-a13d-64ec32e2fc5a	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
eb47d229-866d-4cd3-8f14-46d000892f28	2d585863-97ad-4543-86cf-d83bcc67e635	noun	acuático	una lancha que sirve para viajar por rio	1	t	1854e946-9e1c-4063-a875-f40c1c7edaff	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
e03609b8-0d4b-46ea-bcec-62ff8b994d8c	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	pie	no tenian zapatos iban alo natural 	1	t	056da0f2-6efe-43f0-9630-6981dad99bae	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
253e0223-0568-4bca-bf8f-06398402f136	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	kilómetros	unos 700 kilometros cuadrados	1	t	cae3add6-6b84-428f-83e9-e58287b7de60	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
e078e08e-dc8a-4b0a-ab70-55fb87d72ea1	2d585863-97ad-4543-86cf-d83bcc67e635	action	viaje	solo mayores de 70 años usaban baston	1	t	e1173266-1da6-46f0-93d5-9e9a542e37fe	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
ddb61b11-bb2b-48e9-8399-74a5744f3d58	2d585863-97ad-4543-86cf-d83bcc67e635	action	pesca	pescaban carachama ,bocachico.pes raton  ;  pinchaban con un arpon echo de panbil 	1	t	8e75b885-6685-43a8-96ba-09a6c09d28dd	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
3cd65038-17dd-44f0-85d6-44e6f80f7837	2d585863-97ad-4543-86cf-d83bcc67e635	action	cruzar	es ir de un lado  otro de un rio	1	t	451389e7-2318-49c4-9bb3-eaf3b18a16fb	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
7dce22f1-f202-4e8f-a90b-41ee61624826	2d585863-97ad-4543-86cf-d83bcc67e635	noun	río	 rio curaray	1	t	f1239149-9116-4cec-83a0-de4c9c78f91b	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
d42c45fe-c0d9-45a3-95bf-3b02be18a2ca	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	crecido	cuando el agua esta a un nivel de altura alta	1	t	dbcc6e74-4a31-4a1a-9a98-bd14944017ee	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
2fe9dfbe-77b5-494b-b919-1d69766bf86c	2d585863-97ad-4543-86cf-d83bcc67e635	noun	familiares	 oh algun evento del pueblo vecinas	1	t	25ec1d53-84b3-4d7b-9a1f-c0d42763d1dd	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
51972681-fec1-4950-9ef1-ca4cadaab0eb	2d585863-97ad-4543-86cf-d83bcc67e635	noun	canoa	una lancha que sirve para que puedan viajar por rio	1	t	41caec6f-9dea-40fa-a39a-89d9035b494b	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
8b92f893-7d79-411d-8bfb-c1a73b60679c	2d585863-97ad-4543-86cf-d83bcc67e635	noun	y	unos 7,a,8 personas	1	t	589560ee-f6dc-45ce-bf2c-f0d1c64fd3cf	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
75634e30-05f3-441f-b244-ce73b525b4e3	2d585863-97ad-4543-86cf-d83bcc67e635	action	Utilizan	de abos sexos	1	t	9c781aee-20e3-470a-a7c7-727b740d81a1	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
934000d1-38d5-4690-9a17-3ff453f9976b	2d585863-97ad-4543-86cf-d83bcc67e635	noun	pesca	usaban arpon que es echo de panbil	1	t	173ab249-fea8-4b25-979e-6e8fdbf28762	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
784331f7-45b9-4f41-96ba-7fbcffc4e73f	2d585863-97ad-4543-86cf-d83bcc67e635	noun	rio	(hay varios ,donde mas pescaban fue un lugar menos ondo por cabecera del rio zapino	1	t	c36d9f94-9228-4a02-a541-3105e5c44141	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
9d1ec2bf-9285-4a15-9dd1-69620afe55fa	2d585863-97ad-4543-86cf-d83bcc67e635	action	lluvia	por temporada	1	t	f5581d04-2dd3-41b1-a7a5-764d3f813faa	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
4b85a193-c4dc-4ac8-a4ed-ce12073c65fe	2d585863-97ad-4543-86cf-d83bcc67e635	action	carga	poner las cosas en la lancha	1	t	7d29c84a-93c9-4efa-8d04-033243462871	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
1e14231a-e768-48be-a496-8a92277e3f46	2d585863-97ad-4543-86cf-d83bcc67e635	noun	plátanos	verde maduras	1	t	6565782d-6180-40a6-84dd-30060ac273a9	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
081e1d7f-6aea-477c-b833-32d51c10a096	2d585863-97ad-4543-86cf-d83bcc67e635	noun	yuca	semillas de yuca	1	t	67c85313-a457-4c07-90c2-21eb80a74189	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
a3fbc7fb-0dba-41dd-8be3-a7449537ec7b	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	tipica	palos que son para fundir como base , vigas ,hojas de ongurahuas  todo estos ; podemos encontrar a distacia de cada 20 metros de cada matetial 	1	t	aa803bac-cb3b-470d-b59b-d3f4cdb5ac91	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
aad95e31-5b48-4157-a581-c8e49582b9a3	2d585863-97ad-4543-86cf-d83bcc67e635	noun	día	13 horas de camino durante 2 semanas	1	t	053f8ecc-ffd6-4acc-9d2f-e73c97714a79	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
3a6253ac-e096-41e3-9b36-30694c241787	2d585863-97ad-4543-86cf-d83bcc67e635	action	ayuda	deven utilisar los brasos y la palanca	1	t	3dcd439a-8910-4328-86f4-9ad444f02c2d	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
80cb0c2a-a00e-4a3c-912c-f8eafaa2be4a	2d585863-97ad-4543-86cf-d83bcc67e635	action	palanquear	 usar dos brasos y la palanca	1	t	ea0e67d2-9e2d-4503-b2b6-b070efe70896	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
000b5404-2b2d-490e-ab4a-741a67f0ecb2	2d585863-97ad-4543-86cf-d83bcc67e635	noun	rio	palos caidos ,unos crusados en rio ,otros dentro del rio solo con puntas afuera	1	t	6464584c-ecb6-44b5-98b4-a2cb8bf10575	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
1819c6fa-af88-4189-8705-b54a8b8405ad	2d585863-97ad-4543-86cf-d83bcc67e635	noun	remo	 tipo tablero pero con larga manga para remar	1	t	e0bf3d47-51c5-45c2-925c-16ffcf45b62f	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
6b9c3ef7-741f-4a7e-affc-19baaef9c151	2d585863-97ad-4543-86cf-d83bcc67e635	noun	canoa	 unos 8,a9 metros de lago y 90centimetro de ancho	1	t	1f4f47af-fe22-49f9-b466-675fc93b2ebc	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
6b5fa34f-7765-4b8d-969f-86825a557418	2d585863-97ad-4543-86cf-d83bcc67e635	noun	viento	la palanca deve estar  bajo el agua estar posicion de contra viento	1	t	814bc42d-7653-4973-84b6-84ae2c1e980a	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
6c97bcc1-31c0-47a7-bc58-17ce019935de	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	adelante 	 solo dos personas , uno en la punta y otro atras de la punta	1	t	0cb963cb-30fc-4ced-8dc4-216cb049f5f8	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
14bea6c1-182e-4495-a5e0-a52e047e4d01	2d585863-97ad-4543-86cf-d83bcc67e635	action	controlar 	 deven estar atento para que no pueda ir a otro lado	1	t	4b2ac13f-f055-43ea-b7d0-fb870611a639	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
47dfa373-280e-4334-b3fc-7116b8fda249	2d585863-97ad-4543-86cf-d83bcc67e635	noun	brazos	uno cojido ariva de palanca y otra abajo	1	t	6ca075de-80f1-4ac1-806e-01b4449803e2	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
9c06a303-1401-4be5-963d-beefe7f7a129	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	duro 	con mucha fuersa deven palacar por que el rio es corentoso	1	t	bb44280a-2ef7-4ab9-a446-3ab7ee0bf269	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
94138c3c-4997-4c05-95d6-9089f6d0684b	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	necesite	 solo dos hombres 	1	t	2b2849a2-b423-4dcd-a04b-4fb0fffe5d6e	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
3e84f091-c954-4cd0-9ba5-9756f5ae7429	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	palanca	un palo de 3 metros  ,utilizan junto con la lancha	1	t	57408acd-a711-4bf8-a9ae-965cd06ec747	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
99684c0d-6aaf-4285-8006-4516f3ddc3d3	2d585863-97ad-4543-86cf-d83bcc67e635	action	dañe	deve estar en un lugar seco despues de utilisar	1	t	41cceb5f-e03c-421d-8d72-a9aac029a802	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
bbd06683-19a6-48b5-abb1-3c6b9fb2fe61	2d585863-97ad-4543-86cf-d83bcc67e635	action	shacra	ir a un huerto 	1	t	82cbbf8d-7a26-4236-b3eb-d67e583561a2	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
db0ba104-4ff6-444b-9c15-8a19d50345eb	2d585863-97ad-4543-86cf-d83bcc67e635	noun	pesca	solo por temporada  ,en mes de agosto a enero , marzo a junil	1	t	eea43d5a-2a66-4842-b319-a65360470bff	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
006fbadc-be4a-4538-9a69-5286ef900986	2d585863-97ad-4543-86cf-d83bcc67e635	noun	montañas	 loma de altura muy alta	1	t	e7531112-2e2e-444b-b093-67a392eb4f02	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
7829ce7f-bb7d-40c3-b4f2-a2aa46e304b1	2d585863-97ad-4543-86cf-d83bcc67e635	noun	humanas 	no usaban zapatos	1	t	c823855e-3631-47ab-8768-ded094da0949	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
af29f63c-27b6-4c6d-8e24-1e9b588ec2bf	2d585863-97ad-4543-86cf-d83bcc67e635	action	caminar	solo mayores de 60 años usaban baston	1	t	dab38fef-adb5-458f-99a9-cf0d6bfefffc	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
966247d6-0620-4918-99fa-543235dda45f	2d585863-97ad-4543-86cf-d83bcc67e635	noun	abuelos	Abuelos y Abuelas	1	t	4390388d-b67f-442c-be54-584a8fbcf6d3	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
70738b60-2146-4d22-9662-35a0909d6b8a	2d585863-97ad-4543-86cf-d83bcc67e635	noun	transporte	es un ojepto que sirve para tranportar	1	t	202a4c8a-cbad-455a-a1e1-062120cfd868	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
21f05bfd-945d-4d39-83a0-079be1bdda39	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	acuática 	una lancha para viajar por rio  , rio sellama curaray y otro  cononaco ;  solo dos personas	1	t	8b88536c-d4c8-4bdb-a91b-435bb25d2ae4	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
45f5aff8-d6fc-4195-bc15-83b81f903af3	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	cedro	es un arbol maderable  de hay hacen una lancha	1	t	02e5c679-5251-4ca8-9ed2-ab94dea4d0eb	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
2ed7df47-70c6-4642-8960-325dcdf973c4	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	pesca	solo por rio mas  bajo	1	t	35cb2be8-18f5-4bb2-8061-da96587ec68f	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
277abe6e-f918-4e36-a9a9-64a4d5531616	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	larga 	 300 kilometro	1	t	34fbf08e-914d-48e0-82f7-98eeaed64da0	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
0ae03e3d-5a29-4dba-a80c-69a1cead90c1	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	antiguos 	90 años atras	1	t	e6f3a4a8-7c57-48d2-8e0a-50c110eb1df5	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
4c35ab87-70ca-4a32-b5a0-2addc41f32d9	2d585863-97ad-4543-86cf-d83bcc67e635	context	hoje 	hay de todo pero no todos tienen en su disposicion	1	t	8de29dc9-10ab-41e0-8db0-3ff12d9d092d	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
1ffdc23e-d0c8-4626-ad34-42babd483cad	2d585863-97ad-4543-86cf-d83bcc67e635	noun	transporte	despues de contanto con mundo occidental ; Vemos cosa que podemos utilisar ; Asta hoy dia algunos pueblos caminan a pie por defender su territorio ; Algunas partes la empresa petrolera a destruido la selva 	3	t	1bebafd0-d965-424b-91d9-e17bae1ecb3a	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
303e6bf0-36dc-4dd3-9eb5-c2ab63b78a88	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	wood	first, we need to cut down the tree, make it into long rectangle  at least 10 feet and we cut down it in this middle again about 9 feet of 10 and make it into V shape. And also, we  made axle for the wheels and making all of them in to 90° convex shapes and combine them to be a circle. We also had to make the wood in to egg shape with a small hole in the middle, join all of the poles with it and to make the axle for rolling. Then, we used iron around the circle wheels to protect them from spreading into their original shape again.  At the end of V shape, we have to tie with a long wood and have to make the place with wood or bamboo in to rectangle with the fences for the passenger	1	t	2a560e0c-0f70-4383-8504-4a22daea2c21	2023-03-24 18:03:30.998	2023-03-24 18:03:30.998
93245cea-111c-4ecb-8040-c5060b25168b	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	bamboo	making the holes on the top and bottom of it, tie them with the rope	1	t	66ecf0bf-9b0c-4ef2-9ffb-5718f590227e	2023-03-24 18:03:30.998	2023-03-24 18:03:30.998
32745360-85d3-4abd-bbd5-95944ea49549	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	wheels	 it needs 4 woods it has 4 or 3 poles per one	1	t	d4a61ae3-f1f0-475c-9164-9f952182d668	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
ddef7a62-7f6b-4814-bac6-4f922b8621ed	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	wood	it has two holes and sticks per side in a row for the oxen to pull the cart	3	t	7272344d-8c29-4e75-b8c2-06aa49616c34	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
64ddbfe8-c6c5-4e65-b79b-840006abcf28	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	rope	from tree	1	t	50de5863-fc0c-428b-a655-3013d88c2ee1	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
da7b0723-9b68-4108-b5f8-8b43aec6ba43	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	cart	it has 2 wheels, one sit for driver, place for other people and things and pulling by the oxen	1	t	dfad7db5-b536-406f-8703-228de9af7c4e	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
6a84b687-e929-4a1c-9de1-5667abff37f7	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	far	to travel or go to the event  with group, to export or exchange seasonal foods to other places or towns	1	t	19c8102e-bebb-4906-a52a-b59396e20b59	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
af2301aa-6a80-402f-b096-9113deb016f1	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	heavy	rice, fire woods, leave, bamboos, woods, rocks and other things	1	t	5f88d0b7-1f0a-4d69-9476-a4c542b662ac	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
d414fcf1-eef5-4c42-a439-8279256a8089	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	emergency	it took the patients, pageant women to the traditional doctors and we also used to carry our things and to leave from dangerous places during civil war or unstable situation	1	t	0d872253-c867-44da-94df-cf8e2227251f	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
d91e6df5-16c0-40ff-be4a-96f800f65d4c	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	event 	traditional festivals, weeding	1	t	66223b60-6b94-4a9c-a2a6-5e4393077bd1	2023-03-24 18:03:31.023	2023-03-24 18:03:31.023
deff9dc4-5859-44ec-88c0-6ec38e0701ca	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	group	family, relatives, friends and passengers	1	t	f4a42ba0-f773-4660-81f4-8916abcfa458	2023-03-24 18:03:31.023	2023-03-24 18:03:31.023
6630b10d-7866-48a5-a326-bb7c1be3d4b8	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	boat	one sit for rower in the backside and the passenger had to sit on the middle and front sides. And also, it can carry 4 to 7 people depend on boat side it carries around 1 tone	1	t	728625ec-9147-4e47-89bf-b62cd2f26b90	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
d31e61e8-fafb-4963-861d-b01769617c86	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	work	have to beat these animals by stick to make the animal to run fast and 2 ropes for controlling the oxen to turn left, right, stop for the arrangement	1	t	22dc5726-990b-451e-b68e-c0f19be12809	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
2009a0e4-0440-4ad9-bebb-91208236c8b1	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	paddle	have to make it into flat on the bottom and top must be as handle	1	t	ae536ce2-2ad7-4df6-a08a-abbd8d8bec05	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
05d55ce5-eebd-4d3f-b968-ccba7b67bf43	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	bamboo	has to make it smoothly and around 10 feet tall	1	t	02d93520-8193-4303-8af2-c8a18f8e8364	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
2f0cb83d-68b8-4552-8997-b91735219644	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	stick	it was sharp on the top of the stick	1	t	ecf72a23-382f-46e5-8969-730da7580ff6	2023-03-24 18:03:31.041	2023-03-24 18:03:31.041
0ca821a5-90d3-498e-bd52-78b0394bbff4	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	ropes	one rope from left animal and another rope from right animal. Driver needs to pull the rope with left hand if he or she want to turn the cart to left side and he or she also need to pull the rope with right hand if he or she wants to turn to right side. And also, if he or she wants the animals to stop, she or he needs to pull both ropes at the same time. Sometimes, driver is holding both ropes with his left hand and holding stick with his right hand	1	t	0db30e16-aa17-4495-8ab6-42a0442dedd5	2023-03-24 18:03:31.047	2023-03-24 18:03:31.047
46078d25-766e-48c3-ae49-e34043f81cf2	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	cart	not only in the urban but also in the rural area because they are slower than car, plane, train, bicycle, ship and it can be out of date by following nowadays period	1	t	41cf7a1c-3265-4e2d-a0e4-b71f18c5af0d	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
1eaa2721-b1fd-4c85-93dc-10c931a69dec	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	season	it even can go three or four feet in the deep water in the raining season, it can go everywhere and it is not easy to be broken while we are using it even on the bad road	1	t	fe128081-72cc-4434-8fcf-a9e2d967d241	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
3da55fa0-9407-44cd-b0ad-6f372e79bdb8	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	want	we can make its roof if we want, to protect from the rain and sun	1	t	293263d4-cd0d-4f7f-98b9-781332235141	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
241960fc-8edc-45f2-91cb-85d20c9ff5c3	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	Bulu	ou Fang-Béti	1	t	93c6c23b-0cd6-473d-ae96-4fa17de8b685	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
7be5c2ba-6610-491d-928a-60bf5db70768	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	initié 	qu’on surnomme le Mbômo-mvet	1	t	0755594e-0bd4-43c2-9522-2ce5fa7cf3e9	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
91e8d2f0-a825-4534-8fd7-698118ea5d5e	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	instruments	Parmi ces instruments, nous avons : le tam-tam, les tambours, les calebasses à sonnailles, les tambourins, le balafon, les castagnettes, le diapason, etc.	2	t	45101d38-fa5e-4967-a971-262abe0cf56a	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
4db4797b-566e-48ae-bc17-dd4d808541f2	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	danses	telles que : le djimassa, l’ekalé, le makoné, le engang, le koué, le N’teuh, le mbaya, le kalangou, le djang, l’ambassibé, etc	1	t	1f552a42-82ef-43db-9c42-e5fae8ecda12	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
ed7a33d6-9113-473a-9ef8-f3e94e1e9ca8	a016b260-36f6-4535-b20b-ea7af618ffc3	action	appareils	produisant des sons peu authentiques comparés à ceux des instruments traditionnels	1	t	e6bd2bd5-a50c-476a-bf3c-7c0deeb0c188	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
fef62b89-97e4-4cd6-b57d-5f7a9669bb58	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	Mvet	comporte six grandes parties : une tige de bambou sèche, des cordes sonores, des anneaux en fil de rotin, des calebasses, et une lanière qui est attachée par les deux bouts à la tige de bambou et permet de transporter facilement l’instrument sous forme de bandoulière	1	t	98de7a1b-e091-42e2-9d98-4111597aa656	2023-03-24 18:03:31.117	2023-03-24 18:03:31.117
1c0a1449-35f2-4bcd-a009-5d1c7c0cc4a3	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	Nkuu	c’est un tambour à fente taillé dans un tronc d’arbre, et qui reproduit à merveille le vocabulaire des langues parlées, un système ancestral de codes rythmiques où chaque phrase a sa propre mélodie et son propre rythme pour transmettre des messages codés	1	t	17a534f1-83b9-4823-b0c6-10f412633954	2023-03-24 18:03:31.117	2023-03-24 18:03:31.117
fadf5125-87ef-4bc9-a377-15a68da8ac39	a016b260-36f6-4535-b20b-ea7af618ffc3	action	réparation	en cas de dommage	1	t	583c8de1-1a6b-401d-a930-c813b6f71c7a	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
5634a7db-4e9a-4924-9525-a5af9daa062c	a016b260-36f6-4535-b20b-ea7af618ffc3	context	forêt 	bois, rotin, bambou, écorces d’arbre, peaux séchés des bêtes sauvages, etc.	1	t	bb8700a2-8739-4ab8-8d4a-ea1ae3b1c4ec	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
533cb3a8-0f09-410d-91e7-a5775866f852	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	finis	en fonction des commandes de leurs clients	1	t	031d0e70-b665-4738-b91c-d8e1eb46ba7c	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
a3ea1f7f-169a-4928-9aa5-61579d26d9af	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	distinctifs	lesquels peuvent être utilitaires, esthétiques, artistiques, créatifs, culturels, décoratifs, fonctionnels, traditionnels, symboliques et importants d'un point de vue culturel, religieux ou socia	1	t	5a5d2747-efcd-4ce4-b657-28dab1908d4b	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
f7540b52-83b0-4b89-913a-1f6c4de1882d	a016b260-36f6-4535-b20b-ea7af618ffc3	noun	réputation	car, beaucoup pense qu’elle est le symbole d’une époque ancienne et révolue	1	t	8614e485-bb85-4ab3-9b7c-5ed784bdb04a	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
1bd5e79f-e077-4d1d-8592-5f88397679d2	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	populaire	car les cérémonies au village sont toujours très animées	1	t	18c0121c-ace6-4f84-891f-a5b03d90d01a	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
3bb0f202-563f-4b6b-8be7-7a3ac95e926b	a016b260-36f6-4535-b20b-ea7af618ffc3	action	rituels	pratiqués par les féticheurs et initiés	1	t	54b541cd-e56e-4ebe-932f-f6e9c8d4855d	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
d5b7aca8-862a-4d0a-b300-c75d7fd56fd2	a016b260-36f6-4535-b20b-ea7af618ffc3	action	retrouvent	autour du feu	1	t	4376f618-611f-4992-9d42-78846302d475	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
c7d46daf-3035-41c4-b134-0d040a449bc4	a016b260-36f6-4535-b20b-ea7af618ffc3	action	rassemblements	qui se font depuis la nuit des temps au clair de lune ou à l’occasion d’autres manifestations	1	t	1eb5397e-2269-4c4a-b1da-afefe704c849	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
61ae6eea-85c4-40db-81a9-1ef6b466f34a	a016b260-36f6-4535-b20b-ea7af618ffc3	action	séance	qui se font depuis la nuit des temps au clair de lune ou à l’occasion d’autres manifestations	1	t	1ab23e57-3f15-40e8-83d1-2da8a1aa17b0	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
bc9d34c1-fb1b-42a4-9447-6024280ec38b	a016b260-36f6-4535-b20b-ea7af618ffc3	action	initié	qui est toujours assis au centre lors des cérémonies	1	t	52522716-7ec8-427a-bfaa-769926bd9828	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
1e2cd6b0-23da-4469-88de-d56d4db252da	a016b260-36f6-4535-b20b-ea7af618ffc3	action	maîtrise	des joutes verbales	1	t	a3e3514a-9185-4e15-9e5c-acebe13475e1	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
c6e0b3c4-9f9d-49ab-b98a-363a40df59c7	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	alarmiste	de la situation des musiques traditionnelles	1	t	1e334d20-e36a-424c-a0c0-faaa9a0a672e	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
939b43f5-9b80-4d01-97cc-518d4ea24310	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	enfants	lors des déplacements d'un village à un autre passant par les pistes de la forêt	1	t	865d8eb1-24d6-47ea-aa67-f7fef082abc8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
e1b348f2-dfbf-46f0-a8b5-1414424c4be0	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	culturelles	qui nous sont propres	1	t	f30d7102-eef0-413e-9c82-7f3d4f2ee992	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
a3a3e26c-9ee0-42df-b5b3-d9d2d13bfc94	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	pratiques	communautaires culturelles	1	t	483a8a4c-a46f-4803-9290-87e36b3a9303	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
21b3d592-f4f2-452c-8546-831ce5d8d966	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	Certains	groupes traditionnels ou artistes	1	t	39e7d29b-5d13-45b8-a818-159755bf865d	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
0935fc04-6fe5-449a-8494-3fbd02abfc4a	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	artistiques	en faisant des emprunts aux genres musicaux étrangers	1	t	3d2f643a-69df-4e99-89cf-46092038e6fc	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
a491cbaf-409a-4658-b02a-ad663b71e9b6	a016b260-36f6-4535-b20b-ea7af618ffc3	appreciation	valorisé 	par la nouvelle génération d’artiste et les pouvoirs publics	1	t	c661467d-1559-49f0-a72b-36e1299e417b	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
054d5c43-1d68-4707-8aad-43662e555510	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	cultura	una identidad propia de nuestra etnia	1	t	eadb9c33-2831-4cf4-a381-a1b675905465	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
5c78a6ca-016b-4c18-880e-097b028f3267	2d585863-97ad-4543-86cf-d83bcc67e635	noun	caña	la caña proviene de lengua español	1	t	37af395b-36ea-4465-9e1f-3a01e3473184	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
f2758fe9-c111-4bad-b112-5c315df67fb7	2d585863-97ad-4543-86cf-d83bcc67e635	noun	hombre	ambos hombres y mujres utilisan en tobillos	1	t	6b6cf356-312c-4957-9627-07045228d028	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
4c90206e-5cc2-4a79-959f-4df2007a7e06	2d585863-97ad-4543-86cf-d83bcc67e635	noun	ñanca	palabra ñanca proviene de nuestra lengua materna, wao tededo	1	t	ee2773b5-a475-4dc2-a0cf-2955a48b880a	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
73f8c32e-d16c-4122-a5c3-8d5a4ba6122d	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	árbol 	un arbol frutal que da material 	1	t	fb93d7c0-3de1-47de-9d14-7b1fe256d5df	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
f6695bea-2515-412f-b26a-8fa4d02b91d7	2d585863-97ad-4543-86cf-d83bcc67e635	noun	suena	 al caminar se suena ,como estan amarados juntos y apegados en tobillo 	1	t	26d4a24d-3ef9-48b2-a8b6-73452645505a	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
fb2d4ac8-709d-4c93-97b3-b8f996696af4	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	únicos	 no hay otro en nuestra cultura  instrumento mas  ; hay 2 instrumento disponible en mi comunidad	1	t	fc5b0bf4-7af7-4d32-8f6f-a87314e776dd	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
cf00ef90-9002-42c2-9c4c-6c51992d68d9	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	generación	dependiendo  de avilidad en conseguir hacer sonar la flauta ;  oñ	1	t	badc9b63-2a26-40cd-93a4-81f7cd7c5cb7	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
688d0bd2-433b-49db-a764-e836ee92a303	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	material	caña de hiadugua que es para hacer flauta , oña	1	t	232ce975-a41a-47c2-9dbf-594a2d551220	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
59b284f9-06f4-437f-9912-9158f4d87dda	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	pequeños 	rio miwaguno	1	t	fc7bc72e-9262-400a-99c1-22caa2ccc9f4	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
8c07637f-c0dc-436d-845f-b18a43254439	2d585863-97ad-4543-86cf-d83bcc67e635	action	material 	personas mayores de 15 años en adelante	2	t	bc287c7a-9191-4709-8da2-ff1faf3b36f2	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
95312028-e5eb-4a44-9619-9b9138cedab2	2d585863-97ad-4543-86cf-d83bcc67e635	noun	flauta	y ñanca primero cortan la caña  y dejan por 3 dias para que se seque  ,despues la cortan en medidas y ya esta lista para soplar ala flauta 	1	t	89d58dda-2877-4a64-aaf0-bcd003a8fe21	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
c491b215-e7e5-4173-8d3a-eb6252611510	2d585863-97ad-4543-86cf-d83bcc67e635	noun	grandes	arbol frutal, ñamcawe,decimos en nuesrta lengua wao tededo	1	t	c816c324-a332-4701-8457-f1aa5b11f3b8	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
c6c60222-c68d-4434-a3e4-d6fe8609d1dc	2d585863-97ad-4543-86cf-d83bcc67e635	context	selva	yasuni y territorio ancestral	2	t	1429493f-4b44-4bc3-a375-e1f88bd34c20	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
42395afc-030a-4428-a798-e21fcee93eea	2d585863-97ad-4543-86cf-d83bcc67e635	action	dejan 	las personas que elaboran la flauta	1	t	da1f01f7-61c3-47b9-8dc4-ad7e714fd62d	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
ad5804f9-fda0-471d-83ce-9871bd06cc87	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	medida 	 centimetros de flauta, unos 30 centimetro minimo y 50 centimetro maximo  y  cortan a mano con cuchillo o con machete	1	t	07d3a719-4c7b-4001-ba12-6f8e4acd4a78	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
862a9df0-0853-4d56-aa4f-362f99911d8a	2d585863-97ad-4543-86cf-d83bcc67e635	noun	tribu 	las mujeres solo pueden utulizar la flauta ya hecha por el hombre  no esta permitido  ,pero hay algunas que si lo hacen cuando no tienen su pareja su conyugue 	1	t	4d5a92ba-03a3-476f-be53-8e3208a0e442	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
d6b411cc-2926-41a4-9977-c1326c9fc029	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	justas	  la flauta no deve tener huecos por ningun lado  si no  no puedde dar sonido	1	t	964650c8-cd62-41ac-8886-ad078a5a4476	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
e8e201ba-b137-4e4d-b846-d216b89eddd8	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	mejor 	entre 30 centimetro  de mimimo y 50 centimetro de maximo	1	t	3ec7df8b-c4d2-4b83-9a36-bf85984eac64	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
2e518c88-062b-4f89-81a4-8c473f0b9812	2d585863-97ad-4543-86cf-d83bcc67e635	noun	festivales	competencias en la ciudad , en asambleas  , en matrimonios , en presentacion de bienenida	1	t	8034943a-2780-435a-a981-ef3daa2628a6	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
0b15f857-d1c3-4203-b119-1e3cebf8db5f	2d585863-97ad-4543-86cf-d83bcc67e635	action	danza	 danza grupal de 2 a 20 personas puden hacer 	1	t	40a1eaf2-86d2-443d-a15f-d42aff625bed	2023-03-24 18:03:31.225	2023-03-24 18:03:31.225
0ce60756-8973-4957-a122-5446aaffa2c3	2d585863-97ad-4543-86cf-d83bcc67e635	context	nacionalidades	dia de amazonia ecuatoriana se selebran hay organisan las competencias y participacion que menciono   ; esto son los lugares mas utilizados el instrumento , asbleas de organisacion , concursos de danza y canto ,en evento de matrimonio y en desfildes de algun comeboracion	1	t	71c0c516-bee1-4bdc-8268-b7cc69de87f4	2023-03-24 18:03:31.225	2023-03-24 18:03:31.225
b7f18b3c-ba4c-4b00-94cf-e4f3ac9a7e63	2d585863-97ad-4543-86cf-d83bcc67e635	noun	waorani	nuestra egnia waorani pueblo de reciente contacto hace 70 años 	1	t	d348c3b5-c783-4bfb-a9a9-aa11efd51b26	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
62c3bd46-ea44-4f69-a45d-0852d60a8d58	2d585863-97ad-4543-86cf-d83bcc67e635	noun	Yanca	 es pepas que dan sonidos	1	t	f4d437f3-281e-4c6c-bfcc-4a119d652dc7	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
45c2f932-0b27-4639-aed7-8a959cb4dc65	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	generación	9 generacion	1	t	60a81a88-6969-45f7-a327-b840cf7c2879	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
d1e179c0-1a80-438c-bddc-699ce0a75a7f	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	instrumentos 	900 años	1	t	5eabdc91-75c9-4428-b9eb-b86e02d53dc6	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
a3a6bdb4-8c8f-4d7a-9ad4-61f6185aade8	2d585863-97ad-4543-86cf-d83bcc67e635	appreciation	instrumento	piano electronico , guitara custicas	3	t	eec1e5cf-e638-472e-8637-c08e9c6cbb73	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
f4cc6406-9981-4206-969b-b4d604e98035	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	drum 	making by wood that needs to make with a hole in the middle of the wood start from top to bottom. After that, need to cover with any lather on the top: for beating and tired with many ropes of 360 round of on it	1	t	4d98d489-574a-4bcf-a0e9-801bb858d5b8	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
15a5f9de-4a55-4939-9eac-a626ab9a62fb	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	rope	for easy control and carry the pot drum when playing it. that is heavy material because it's making by wood	1	t	6c21045d-d99d-4d8f-812d-ff0572559921	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
4333e91c-4667-420f-8d49-4ecf055fe4f6	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	glass	 big top of head and small in the bottom side	1	t	6d3959ec-3628-4e81-b257-aa9aad257b33	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
4a01285e-14ae-42a9-9a58-a4450301f615	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	horn	it has curvature shape: flat at bottom side and sharply at top and also it is hole inside of the horn after we take of the emollient of meat	1	t	5868ddcb-5794-4696-84d5-fa70e7c64133	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
8e53f197-7125-42a6-8de8-4e7081a16203	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	power 	Ta Lar Kone people follow the song of buffalo horn anytime even on the field or other places, come back to their village	1	t	95c27eba-1647-4863-b059-899cb99660b9	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
e724f2a9-b2cb-4fb8-a02e-009ee41e8ba3	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	gathering  	Ta Lar Kone people follow the song of buffalo horn anytime even on the field or other places, come back to their village	1	t	54b4ef0f-9106-4147-ab56-db461c62fb86	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
dcb877d3-bd8c-4377-afe4-26028d69c30b	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	power 	Ta Lar Kone people follow the song of buffalo horn anytime even on the field or other places, come back to their village	1	t	831331f1-161a-4c54-87d3-e6d6af1d5644	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
c027ca3f-d792-4e0c-a076-b94e44fac98a	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	gathering	using it when Ta La Kone people have meeting or discussion in the village and also when going around in village for donation and begging , going around house by house to get budget for village activity	1	t	91fb5891-74d3-4840-b976-56448b4a9fa7	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
00f1794f-e178-4108-9f37-1b5a66b2fe51	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	materials	especially Gong and cymbal	1	t	8376726a-026d-49bc-922a-1c41a35a572c	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
61b46c2e-9dd4-4dd1-b476-27c0ddc9879b	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	difficult	because they are vegetarian never kill and eat the animals	1	t	94567ac3-ade7-49d6-a557-6c0f269eb729	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
2ef1b2fb-18a4-4e73-a0e3-024b70be3ddd	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	died	animal that have killed by other animals	1	t	6bd28836-a519-47ed-8e1b-b39a12ac64f8	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
9975b793-160a-4400-a299-b01009458bcd	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	tree 	must be hard and straight wood	1	t	7e029276-b387-4161-ae71-c694d7f2c392	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
6cc3d64f-310a-4a20-b157-47a93c16896f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	copper 	(it’s a kind of road like gold	2	t	cde56d54-19f6-4f17-af0e-f265653d48cc	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
04be794a-cf45-4583-ab68-1f1190128eb9	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	dig  	digging the ground 1 feet deep and around	1	t	e9117cb7-a9b6-469f-ab26-a89c32cf41ef	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
98b90adc-ed42-42b8-9f55-68d7c155b666	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	smooth	refined the place with a little water and every side and conner	1	t	cef2835c-fedb-4f65-811a-c2ccfeb1a404	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
adee1af4-cd74-4a0d-a6e8-db14dddd9773	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	exchange	Ta Lar Kone people are going village by village that have killed the animal and keeping the lather and horn	1	t	a0631992-bca4-479a-9163-f19b98dcc0f5	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
201ef007-a3b1-4fef-94ee-f8444ab1975d	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	fruit	lemon, coconut, bean	1	t	c7a7a5fc-683f-4ced-a228-860f12fc30cb	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
3e4f2c3b-64f7-42be-8db1-007155b8a789	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	mountain	together digging the copper’s rock 6 days per month, sometimes it takes more than 3 years to get copper’s rock	2	t	bdf4e2dd-4f24-4fd6-b4dc-6223c08610a1	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
19e719a2-f69e-4af0-bfae-f74155b18819	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	Gog	it is a cycle shape which has bumpy in the middle and round cycle with the fence	2	t	f345132c-08fa-4445-ac10-906139c37b51	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
c2e70bdf-e4db-4945-8d6f-7964e18310d7	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	Cymbal	it’s a cycle shape that has bumpy in the middle as well but need to make a small hole on each side to tie the rope could be short and also long for play it	2	t	82f52316-d44d-4303-8094-7349658eb0fe	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
358ccfb6-ae81-4d1a-a691-b44e8555c70f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	material	horn, gong, lather, copper	1	t	400a8361-0372-405c-aae7-8e799a9a1252	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
43169194-6e7b-4f29-a673-9d7a81afff1f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	tree	4 to 5’ feet long and start cut off the side of the tree to get smoothly until become a cycle shape, colonnade shape of wood,, after that, make a hole by starting form bottom to upper to the wood	1	t	fdb0c724-417b-4d59-9fdb-e39cf4318c81	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
1aa2ed9b-d0f8-4627-a4f7-45abe277c164	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	lather	and also, need to mount on the ground with round small sticks, making small bamboo plant on round of lather, same keep it in under of the sun shine until dry	2	t	1ad332c8-03f4-4966-8c1a-08baf60f3a49	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
ec27852d-347e-445a-bd62-c7026224479e	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	horn	Make a rectangle shape on the middle and small cycle hole close to top. Need to cover half of the rectangle shape with bamboo plate. In the end we can play it and it can produce nice song forever	2	t	b3c301bf-ee15-4c38-b8f5-cb6189dade0b	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
dc5713db-bc26-4c2e-a0e3-4e07c1215e36	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	Gog	for the rope, to carry it	3	t	ff60a970-506a-4917-a962-55c007ecdc59	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
510039f3-eca8-4c54-8f87-afc27d122b93	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	stick	with tied by cloth on head	1	t	2887e4ad-70c5-4b08-b36c-fe5d9e9ee2cd	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
b95f5480-1b38-4396-a3f0-68905e35a7ba	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	festival	They cut down of the plant of the rice and keep it to the same place	2	t	d751c482-4e92-440b-884d-351bae98ca24	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
efbb82cd-deb6-45d5-8db2-0334aad244e4	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	horn 	that will carry lucky for them	1	t	9bdfae74-7fd4-4afa-a0c0-267a846f1425	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
2ad0ad64-2e08-486e-b079-f26daffc5e63	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	Gog 	mean to bring the power man power	1	t	a7efa68a-4a28-4f17-abe4-a5c94b2b3a97	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
8f6db7cc-35f5-4d2b-b63f-735ed84b2e72	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	Drum 	to be strong and active on every situation	1	t	e054a9cd-def0-4c2d-ae87-596bc634da36	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
8be7d56e-15c7-4a0b-bc0e-17ef3fad833d	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	song 	going rotate the ground again and again for two to three hours and have a brake for while then restart going around on the plants	1	t	2962dece-8cae-4670-9c97-e87e48839230	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
dc820f5e-703f-4ec3-94df-aeff27b474bc	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	planting 	Because, buffalo like to eat green plant	1	t	8ac5f154-ba0a-4507-b64f-f465e9c897b6	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
6653fbdf-c759-4371-b2e3-5980aebdd9a4	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	things	house, meeting room, pray room, digging well	1	t	fcc59c3a-bc47-4294-8158-cdc5262e37d9	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
0803c99d-3302-4b86-bf31-a85cd6baff17	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	instruments	they still have 2 musical instruments that have built by bamboo. One is short and big that have rectangle hole on the of the bamboo and the other one is long bamboo that have 2 handles for playing it ; the cut off the bamboo to become smaller to hold it	1	t	ecd91915-d16b-4b41-aa67-9ac47e0bac23	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
f1d16b1b-1ee6-423b-b99b-bf12fbcac006	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	4	because, most ethnic group from Myanmar are using that 2 items nowadays	1	t	1cc83a45-2bed-4a50-badf-d373f66523a7	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
117ac5fa-19fb-44fc-896c-bed96aa68ee0	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	ethnic	Karen, Mon, Chin, Burma, Rakhine, Shan, Kachin, including Pa Oh	1	t	96041adb-8901-45dd-88fa-e9165ed01ace	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
75772855-4ebf-4862-afbd-e242943e2e46	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	ethnic	who are living in Northern of Myanmar, Buffalo horn same with Karen ethnic group : people who are living on the mountain in Myanmar country	2	t	8badaee0-dbe9-4b97-8d4b-3f65f7afed89	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
b62a39b1-eea5-44b7-9228-7d517cf10961	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	appreciation	meaning	like bring a luck for their people and curry up their mindset	1	t	e7359065-3372-41b6-8d5e-a9173b534d99	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
c28384fc-12ba-4d60-a565-d99b021ad037	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	playing	they play only when they have festival, some activity and build something in their community no other else	1	t	8d2e5294-c604-44cb-ba88-b2c3c7528c05	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
ff7c7a54-f3c6-4aae-a4cd-5566e33cb9c4	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	context	community	they still very politely, quietly, follow their role of responsibility carry to next-by-next generation	1	t	d4e1e448-c73a-4ef8-8f77-4685058b0e82	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
4c13c683-c76b-46ee-80ca-f75963c36763	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	action	meditation	every full moon day, hidden moon day, new moon and waning moon day	1	t	4e5aeca3-6334-49b2-918f-8d4457241a47	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
6c9ac3ba-9c3b-4a31-b049-d0a3a947c4a7	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	noun	people 	produce the song or album, movie, and karaoke	4	t	a5053650-db10-4a69-be57-7b053e7e85cf	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
\.


--
-- TOC entry 3464 (class 0 OID 16450)
-- Dependencies: 219
-- Data for Name: Question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Question" (id, "userId", "themeId", "createdAt", "updatedAt", "isOpenThemeQuestion") FROM stdin;
adf3efcf-3d18-4676-8193-6db5e083c5ad	3944149f-07ad-4345-a893-229258d18578	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.34	2023-03-24 18:03:29.34	f
7ed380ab-12bd-4185-8b4a-e7254bab5e10	3944149f-07ad-4345-a893-229258d18578	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.351	2023-03-24 18:03:29.351	f
b275c684-6970-4ed3-bb22-d22ef3d9c59a	3944149f-07ad-4345-a893-229258d18578	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.357	2023-03-24 18:03:29.357	f
07bb5ed0-e638-4258-819d-973686881a39	3944149f-07ad-4345-a893-229258d18578	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.362	2023-03-24 18:03:29.362	f
8cce9cea-808f-487c-a24e-1dcf03985f44	3944149f-07ad-4345-a893-229258d18578	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.366	2023-03-24 18:03:29.366	t
ebb2c446-395f-478e-8276-cf9bd8736504	3944149f-07ad-4345-a893-229258d18578	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.901	2023-03-24 18:03:29.901	f
6053e34b-204b-4cbc-be67-7d6bf468c594	3944149f-07ad-4345-a893-229258d18578	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.906	2023-03-24 18:03:29.906	f
b09e1c34-5179-4ad4-812a-64f19acf04ba	3944149f-07ad-4345-a893-229258d18578	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.91	2023-03-24 18:03:29.91	f
2a2c46f6-716a-4277-90e0-aaf19b6edd2f	3944149f-07ad-4345-a893-229258d18578	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.919	2023-03-24 18:03:29.919	f
1042f7a3-ae18-4ff3-bef1-bf27ece76b6e	3944149f-07ad-4345-a893-229258d18578	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.927	2023-03-24 18:03:29.927	t
98876855-5737-4e81-a74c-c15b9e3b3a92	3944149f-07ad-4345-a893-229258d18578	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.307	2023-03-24 18:03:30.307	f
fbf4ddcb-3278-49e3-968a-6fff4263f130	3944149f-07ad-4345-a893-229258d18578	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.311	2023-03-24 18:03:30.311	f
4eefe735-93d2-46ed-93ad-660b3dc286fb	3944149f-07ad-4345-a893-229258d18578	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.315	2023-03-24 18:03:30.315	f
ce9d2562-1bf9-4944-adaa-f3860f7d6223	3944149f-07ad-4345-a893-229258d18578	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.319	2023-03-24 18:03:30.319	f
026120a2-063a-40f3-94b3-53a1a88ae708	3944149f-07ad-4345-a893-229258d18578	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.323	2023-03-24 18:03:30.323	t
211a5198-12e3-416c-ac3c-c71027c2793d	3944149f-07ad-4345-a893-229258d18578	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.746	2023-03-24 18:03:30.746	f
3c2b2f43-4abf-4f59-a347-8336f479b653	3944149f-07ad-4345-a893-229258d18578	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.75	2023-03-24 18:03:30.75	f
ee33248a-9125-4a32-91e0-a1e45a67209b	3944149f-07ad-4345-a893-229258d18578	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.755	2023-03-24 18:03:30.755	f
c2a30f2a-eb66-41c2-81cd-99122f664698	3944149f-07ad-4345-a893-229258d18578	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.761	2023-03-24 18:03:30.761	f
c808858d-7de5-40d6-9abe-6377e457a278	3944149f-07ad-4345-a893-229258d18578	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.765	2023-03-24 18:03:30.765	t
8e951538-6548-498c-b3aa-d42dd3bbb6d5	3944149f-07ad-4345-a893-229258d18578	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.076	2023-03-24 18:03:31.076	f
e4be3911-6b43-46b2-b41a-1a08e3d88ad8	3944149f-07ad-4345-a893-229258d18578	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.081	2023-03-24 18:03:31.081	f
e101f909-9cbd-45bf-a0ba-99f52739671e	3944149f-07ad-4345-a893-229258d18578	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.09	2023-03-24 18:03:31.09	f
8585bdfa-1671-471d-aa59-c583edd4171d	3944149f-07ad-4345-a893-229258d18578	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.094	2023-03-24 18:03:31.094	f
20cf0f57-3e1e-403d-830b-c65bfe806e21	3944149f-07ad-4345-a893-229258d18578	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.098	2023-03-24 18:03:31.098	t
\.


--
-- TOC entry 3469 (class 0 OID 16548)
-- Dependencies: 224
-- Data for Name: QuestionTranslation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionTranslation" (id, "questionText", "isOriginalQuestion", "languageId", "questionId", "createdAt", "updatedAt") FROM stdin;
7dcdf929-2450-40c1-91df-ee4f87360310	Pour le mariage, comment choisissiez-vous/choisit-on votre partenaire ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	adf3efcf-3d18-4676-8193-6db5e083c5ad	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
e2874d3f-bc6d-4acb-9a3a-fe8243fd931a	For the wedding, how did you/they choose your partner ?	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	adf3efcf-3d18-4676-8193-6db5e083c5ad	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
d4578131-f965-4599-9400-bfc6d88d57f6	Para la boda, ¿cómo eligieron a su pareja?	f	2d585863-97ad-4543-86cf-d83bcc67e635	adf3efcf-3d18-4676-8193-6db5e083c5ad	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
1a0b8059-420b-4638-9dc9-b7ab7db77307	Comment sont les habits utilisés avant, après et pendant le mariage ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	7ed380ab-12bd-4185-8b4a-e7254bab5e10	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
1fa80447-64b3-43aa-91e0-7bba04ae74f2	How are the clothes used before, after and during the wedding ?	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	7ed380ab-12bd-4185-8b4a-e7254bab5e10	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
67a9c091-eeef-4a94-8359-3fc91cfda391	¿Cómo se utiliza la ropa antes, después y durante la boda?	f	2d585863-97ad-4543-86cf-d83bcc67e635	7ed380ab-12bd-4185-8b4a-e7254bab5e10	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
d274ec30-8f30-4f51-a6f6-224a29eddf08	Comment se déroule la ou les cérémonies du mariage ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	b275c684-6970-4ed3-bb22-d22ef3d9c59a	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
1b3e80ba-c79f-4422-a43e-ca54b1bab373	How does the wedding ceremony or ceremonies take place ?	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	b275c684-6970-4ed3-bb22-d22ef3d9c59a	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
3cad4a4c-1a6b-43ea-be26-5a0b2fdbe900	¿Qué ocurre en la(s) ceremonia(s) nupcial(es)?	f	2d585863-97ad-4543-86cf-d83bcc67e635	b275c684-6970-4ed3-bb22-d22ef3d9c59a	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
5323ea8e-1647-49d7-95ac-7ebdd686ac40	Qui légitime le mariage, comment et par quelle autorité ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	07bb5ed0-e638-4258-819d-973686881a39	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
53700327-509b-41b0-97da-028174818acb	Who legitimizes marriage, how and by what authority ?	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	07bb5ed0-e638-4258-819d-973686881a39	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
9faad993-6c57-4121-9907-ceae6e567959	¿Quién legitima el matrimonio, cómo y con qué autoridad?	f	2d585863-97ad-4543-86cf-d83bcc67e635	07bb5ed0-e638-4258-819d-973686881a39	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
576b14b0-494e-4e4c-aa24-68eed6fdf5d4	Qu'avez-vous à dire sur ce thème ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	8cce9cea-808f-487c-a24e-1dcf03985f44	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
117acf58-8b99-473a-9eb9-befaab95c8d0	What do you have to say about this topic ?	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	8cce9cea-808f-487c-a24e-1dcf03985f44	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
d6f94499-fe47-4959-b01d-9a9325232428	¿Qué tiene que decir sobre este tema?	f	2d585863-97ad-4543-86cf-d83bcc67e635	8cce9cea-808f-487c-a24e-1dcf03985f44	2023-03-24 18:03:29.371	2023-03-24 18:03:29.371
c7afbad9-12a8-44e1-8e10-167af3647d01	Comment faisiez-vous avant, pour fabriquer des tissus/fils, qui servaient ensuite à faire les habits ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	ebb2c446-395f-478e-8276-cf9bd8736504	2023-03-24 18:03:29.932	2023-03-24 18:03:29.932
9f7cfa1d-7b45-4ffc-9cb1-d8e0dd5d1a21	Comment faisiez-vous avant, pour fabriquer vos habits ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	6053e34b-204b-4cbc-be67-7d6bf468c594	2023-03-24 18:03:29.932	2023-03-24 18:03:29.932
603e5e93-52a4-49ef-b8c3-f62d0ab56262	Comment faisiez-vous avant, pour teindre vos tissus/habits avant d'acheter des teintures ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	b09e1c34-5179-4ad4-812a-64f19acf04ba	2023-03-24 18:03:29.932	2023-03-24 18:03:29.932
1e4f490b-6ce1-4f01-b257-3cdcccf865bc	Comment faisiez-vous avant, pour décider le style, la forme et les illustrations de vos habits ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	2a2c46f6-716a-4277-90e0-aaf19b6edd2f	2023-03-24 18:03:29.932	2023-03-24 18:03:29.932
8b4fcc31-adcb-4124-a0a4-4433d2a21a33	Qu'est-ce qu'on entend ou entendait par costume traditionnel ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	1042f7a3-ae18-4ff3-bef1-bf27ece76b6e	2023-03-24 18:03:29.932	2023-03-24 18:03:29.932
a51ef518-b9db-4276-9543-db0dd7d1f0e8	Comment faisiez-vous pour trouver/fabriquer les matériaux-substances-éléments que vous utilisez pour faire le toit, le sol, les murs de votre bâtiment communautaire ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	98876855-5737-4e81-a74c-c15b9e3b3a92	2023-03-24 18:03:30.327	2023-03-24 18:03:30.327
176c5ce3-a930-41f3-a1de-c41e46624785	Comment et dans quel ordre utilisiez-vous les matériaux-substances-éléments pour faire le toit, de sol, les murs de votre bâtiment communautaire ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	fbf4ddcb-3278-49e3-968a-6fff4263f130	2023-03-24 18:03:30.327	2023-03-24 18:03:30.327
e1cfd4e3-37f1-413c-ae75-2fbd37c52c46	D'où venaient la forme, la taille, le style d'architecture de votre bâtiment communautaire ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	4eefe735-93d2-46ed-93ad-660b3dc286fb	2023-03-24 18:03:30.327	2023-03-24 18:03:30.327
16e60ae6-c998-4086-878a-baec83e9b4a0	Avant, quels objets et autres spécificités différenciaient ce bâtiment communautaire des bâtiments où vous viviez ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	ce9d2562-1bf9-4944-adaa-f3860f7d6223	2023-03-24 18:03:30.327	2023-03-24 18:03:30.327
a7e0a0f2-59ad-4ee7-8161-bdba6f9c64bb	Construire des bâtiments communautaires en utilisant des méthodes, des outils ou des équipements anciens	t	a016b260-36f6-4535-b20b-ea7af618ffc3	026120a2-063a-40f3-94b3-53a1a88ae708	2023-03-24 18:03:30.327	2023-03-24 18:03:30.327
289b521d-4811-48c6-9590-1df4d14acffb	Quels étaient vos anciens moyens de transport et de quoi étaient-ils faits ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	211a5198-12e3-416c-ac3c-c71027c2793d	2023-03-24 18:03:30.769	2023-03-24 18:03:30.769
698def38-9297-4cc0-b595-23dc5374696b	Pour quelles occasions les utilisez-vous ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	3c2b2f43-4abf-4f59-a347-8336f479b653	2023-03-24 18:03:30.769	2023-03-24 18:03:30.769
446a15d4-888a-4f7a-b109-4ee9179643ec	Comment fonctionne-t-il ? Et qu’est-ce qui est nécessaire pour qu’ils fonctionnent ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	ee33248a-9125-4a32-91e0-a1e45a67209b	2023-03-24 18:03:30.769	2023-03-24 18:03:30.769
8d3f3fe0-5b64-4bf4-9426-960ccdf1348c	Quelles parties du corps humain sont nécessaires pour l’utiliser ? Et comment l’utiliser au mieux ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	c2a30f2a-eb66-41c2-81cd-99122f664698	2023-03-24 18:03:30.769	2023-03-24 18:03:30.769
5394fa2e-d2ee-4488-94bf-faf0a091c0d8	Ce que vous voulez dire sur ce thème	t	a016b260-36f6-4535-b20b-ea7af618ffc3	c808858d-7de5-40d6-9abe-6377e457a278	2023-03-24 18:03:30.769	2023-03-24 18:03:30.769
c07a8b8f-714a-47cb-be0e-485aa2893c0e	Comment faisiez-vous avant, pour fabriquer des tissus/fils, qui servaient ensuite à faire les habits ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	8e951538-6548-498c-b3aa-d42dd3bbb6d5	2023-03-24 18:03:31.102	2023-03-24 18:03:31.102
6e72fc07-d55d-4776-9ac3-b819b7148d83	Comment faisiez-vous avant, pour fabriquer vos habits ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	e4be3911-6b43-46b2-b41a-1a08e3d88ad8	2023-03-24 18:03:31.102	2023-03-24 18:03:31.102
56f79283-7694-4110-8d89-eefc6e5bb073	Comment faisiez-vous avant, pour teindre vos tissus/habits avant d'acheter des teintures ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	e101f909-9cbd-45bf-a0ba-99f52739671e	2023-03-24 18:03:31.102	2023-03-24 18:03:31.102
d74554b9-7c2c-40f6-b736-0d629f6c0490	Comment faisiez-vous avant, pour décider le style, la forme et les illustrations de vos habits ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	8585bdfa-1671-471d-aa59-c583edd4171d	2023-03-24 18:03:31.102	2023-03-24 18:03:31.102
bb7cf56d-4e6e-4568-b053-74a20bfb7a4e	Qu'est-ce qu'on entend ou entendait par costume traditionnel ?	t	a016b260-36f6-4535-b20b-ea7af618ffc3	20cf0f57-3e1e-403d-830b-c65bfe806e21	2023-03-24 18:03:31.102	2023-03-24 18:03:31.102
\.


--
-- TOC entry 3460 (class 0 OID 16417)
-- Dependencies: 215
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Role" (id, role, "createdAt", "updatedAt") FROM stdin;
4260139d-ec38-4295-92d8-d179e69a5946	user	2023-03-24 18:03:29.212	2023-03-24 18:03:29.212
5bc1f4fd-f00d-403c-89ee-7732dd9cf5d1	admin	2023-03-24 18:03:29.233	2023-03-24 18:03:29.233
b845cd67-32ec-41aa-b709-5ea55915e59d	representative	2023-03-24 18:03:29.237	2023-03-24 18:03:29.237
\.


--
-- TOC entry 3462 (class 0 OID 16433)
-- Dependencies: 217
-- Data for Name: Theme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Theme" (id, "isSelected", "userId", "createdAt", "updatedAt") FROM stdin;
588e58a5-1783-455a-86c3-25ed89a6b71e	t	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-31 22:00:00	2023-03-24 18:03:29.326
60b840c6-79b6-47a6-b365-1700d1192e49	t	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-31 22:00:00	2023-03-24 18:03:29.892
3b1a0617-1149-42d4-ada3-4044f12717cf	t	3df7c44f-f62e-4279-80c2-bca753102fac	2023-03-31 22:00:00	2023-03-24 18:03:30.297
1fba486c-0fbf-4488-a3ce-d4d144688002	t	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-31 22:00:00	2023-03-24 18:03:30.737
33cee886-1cc3-41b8-8859-01af609a507a	t	97224ed8-99ed-430f-8eb2-6f79dfe75564	2023-03-31 22:00:00	2023-03-24 18:03:31.067
\.


--
-- TOC entry 3468 (class 0 OID 16538)
-- Dependencies: 223
-- Data for Name: ThemeTranslation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ThemeTranslation" (id, "themeName", "isOriginalTheme", "languageId", "themeId", "createdAt", "updatedAt") FROM stdin;
65a51d04-2c0a-4a1f-8eeb-965f099b643a	Le mariage traditionnel	t	a016b260-36f6-4535-b20b-ea7af618ffc3	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.335	2023-03-24 18:03:29.335
7c3471ad-3d25-44b2-a9e0-8a1f5ab980e5	El matrimonio tradicional	f	2d585863-97ad-4543-86cf-d83bcc67e635	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.335	2023-03-24 18:03:29.335
c870317c-c587-4681-bf82-d0106303df34	Traditional marriage	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	588e58a5-1783-455a-86c3-25ed89a6b71e	2023-03-24 18:03:29.335	2023-03-24 18:03:29.335
04bb03d7-c5b6-40fb-a159-e517f6ce9ee7	Les costumes traditionnels	t	a016b260-36f6-4535-b20b-ea7af618ffc3	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.898	2023-03-24 18:03:29.898
46517724-e786-4639-a44f-07a1c7aeeb2c	Trajes tradicionales	f	2d585863-97ad-4543-86cf-d83bcc67e635	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.898	2023-03-24 18:03:29.898
cb081058-01d4-4694-a23b-d5febff1efdb	Traditional costumes	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	60b840c6-79b6-47a6-b365-1700d1192e49	2023-03-24 18:03:29.898	2023-03-24 18:03:29.898
fc619b07-f01a-4ac6-bca4-75dc6f3a2e48	Batiment communautaire traditionnel	t	a016b260-36f6-4535-b20b-ea7af618ffc3	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.304	2023-03-24 18:03:30.304
9125700d-520d-4b14-9be6-17f2d1c3b839	Construcción tradicional de comunidades	f	2d585863-97ad-4543-86cf-d83bcc67e635	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.304	2023-03-24 18:03:30.304
989beea4-758b-46b9-b490-804becd02661	Traditional community building	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	3b1a0617-1149-42d4-ada3-4044f12717cf	2023-03-24 18:03:30.304	2023-03-24 18:03:30.304
3b64dea9-c847-49a2-ba16-9a612750d4bc	Les transports	t	a016b260-36f6-4535-b20b-ea7af618ffc3	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.743	2023-03-24 18:03:30.743
1dd0523f-7dbc-460d-8872-661341752849	Transporte	f	2d585863-97ad-4543-86cf-d83bcc67e635	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.743	2023-03-24 18:03:30.743
f5d099a7-f272-4f63-809f-87c76affd1c1	Transports	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	1fba486c-0fbf-4488-a3ce-d4d144688002	2023-03-24 18:03:30.743	2023-03-24 18:03:30.743
015ddcf5-9781-4df0-bcd1-8eb04b36ee0b	Les instruments de musique	t	a016b260-36f6-4535-b20b-ea7af618ffc3	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.073	2023-03-24 18:03:31.073
880d94e2-e5dc-4f63-9fef-56cd69369375	Instrumentos musicales	f	2d585863-97ad-4543-86cf-d83bcc67e635	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.073	2023-03-24 18:03:31.073
dbdf388e-1834-44c0-96fc-ecb64a0fd08a	Music instruments	f	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	33cee886-1cc3-41b8-8859-01af609a507a	2023-03-24 18:03:31.073	2023-03-24 18:03:31.073
\.


--
-- TOC entry 3461 (class 0 OID 16424)
-- Dependencies: 216
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, "firstName", "lastName", email, password, "roleId", "createdAt", "updatedAt", "commonLanguageId", "culturalLanguageId") FROM stdin;
3944149f-07ad-4345-a893-229258d18578	Admin	Istrateur	admin@cs.com	password	5bc1f4fd-f00d-403c-89ee-7732dd9cf5d1	2023-03-24 18:03:29.299	2023-03-24 18:03:29.299	a016b260-36f6-4535-b20b-ea7af618ffc3	a016b260-36f6-4535-b20b-ea7af618ffc3
3df7c44f-f62e-4279-80c2-bca753102fac	Jose	Ramirez	jose@cs.com	password	4260139d-ec38-4295-92d8-d179e69a5946	2023-03-24 18:03:29.304	2023-03-24 18:03:29.304	2d585863-97ad-4543-86cf-d83bcc67e635	2d585863-97ad-4543-86cf-d83bcc67e635
741f081e-6a83-4c81-a505-a1ff5433c69f	Maria	Hunter	maria@cs.com	password	4260139d-ec38-4295-92d8-d179e69a5946	2023-03-24 18:03:29.307	2023-03-24 18:03:29.307	2d585863-97ad-4543-86cf-d83bcc67e635	2d585863-97ad-4543-86cf-d83bcc67e635
66e7c0a8-fda9-4c04-8edf-fe9047608265	Zhijang	Lee	zhijang@cs.com	password	4260139d-ec38-4295-92d8-d179e69a5946	2023-03-24 18:03:29.31	2023-03-24 18:03:29.31	6f458c4d-df13-4235-b3c2-1d9fc9df7e34	6f458c4d-df13-4235-b3c2-1d9fc9df7e34
27d95f2d-2d45-4a88-9f6f-cd21e0182caf	Mehdi	Zapata	mehdi@cs.com	password	4260139d-ec38-4295-92d8-d179e69a5946	2023-03-24 18:03:29.312	2023-03-24 18:03:29.312	a016b260-36f6-4535-b20b-ea7af618ffc3	a016b260-36f6-4535-b20b-ea7af618ffc3
97224ed8-99ed-430f-8eb2-6f79dfe75564	byron	Zapata	mehdi@cs.com	password	4260139d-ec38-4295-92d8-d179e69a5946	2023-03-24 18:03:29.314	2023-03-24 18:03:29.314	a016b260-36f6-4535-b20b-ea7af618ffc3	a016b260-36f6-4535-b20b-ea7af618ffc3
96601638-0db6-4ebe-bdd2-a4ce9a5fff32	maurice	Zapata	mehdi@cs.com	password	4260139d-ec38-4295-92d8-d179e69a5946	2023-03-24 18:03:29.317	2023-03-24 18:03:29.317	a016b260-36f6-4535-b20b-ea7af618ffc3	a016b260-36f6-4535-b20b-ea7af618ffc3
b11f026f-96b3-4be3-85a9-7640f7d914a6	saw	Zapata	mehdi@cs.com	password	4260139d-ec38-4295-92d8-d179e69a5946	2023-03-24 18:03:29.318	2023-03-24 18:03:29.318	a016b260-36f6-4535-b20b-ea7af618ffc3	a016b260-36f6-4535-b20b-ea7af618ffc3
\.


--
-- TOC entry 3467 (class 0 OID 16478)
-- Dependencies: 222
-- Data for Name: Validation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Validation" (id, difficulty, efficiency, "takenTime", "answerId", "createdAt", "updatedAt") FROM stdin;
0ef122c0-8011-470f-b83b-81d5fac02d99	1	2	100000	d87e4045-d981-4deb-88f4-77ce32399e3b	2023-03-24 18:03:29.377	2023-03-24 18:03:29.377
ef996547-bcd7-4594-9e6a-5eba5106c5c6	1	2	100000	e98b7495-3019-42fa-80fb-363468a82ac2	2023-03-24 18:03:29.4	2023-03-24 18:03:29.4
911fb6b2-78d6-427b-9310-6721043ae4bc	1	2	100000	52da8df5-b0d1-46fc-9e17-828723aaeb63	2023-03-24 18:03:29.422	2023-03-24 18:03:29.422
a00edf45-9adc-4635-832b-79a089d9f3f1	1	2	100000	e727b6c6-b90d-42a9-887b-35106ace7898	2023-03-24 18:03:29.442	2023-03-24 18:03:29.442
c65fc1d9-2545-41ca-bd7f-edaebca897d3	1	2	100000	3c884f25-df39-4f76-888d-36120a7cf6fe	2023-03-24 18:03:29.467	2023-03-24 18:03:29.467
8a35eb8e-c8a5-482f-ad24-fecedc2676db	1	2	100000	64fbe717-6af0-49d7-9737-1b5d5869573a	2023-03-24 18:03:29.49	2023-03-24 18:03:29.49
04bdba9c-31a3-4004-ac28-e96fbb82fef6	1	2	100000	df7d167f-2318-4c24-87d2-df796ff4254d	2023-03-24 18:03:29.52	2023-03-24 18:03:29.52
b2f34f4a-43cc-40bb-9398-80e183f206e0	1	2	100000	17ac63c5-0682-44fa-83c8-cf87a9980bea	2023-03-24 18:03:29.55	2023-03-24 18:03:29.55
5110d4bc-1e17-445b-8b38-8b75a22585d7	1	2	100000	438a9193-6803-4b83-b6c2-15b78ea9a293	2023-03-24 18:03:29.591	2023-03-24 18:03:29.591
424476e3-9bc5-4526-bc4a-671ac567a7e4	1	2	100000	dec5b050-ac80-4a0d-a52b-4ed0c54641ae	2023-03-24 18:03:29.619	2023-03-24 18:03:29.619
f88c0b53-1860-4029-9048-a4c5a183e3bc	1	2	100000	994216b4-1b02-4fbe-a72d-ab9fbc99d636	2023-03-24 18:03:29.795	2023-03-24 18:03:29.795
740ed55d-da69-4970-ad35-611ddf112b2f	1	2	100000	20de7465-c67b-4358-b4f6-842518854d8a	2023-03-24 18:03:29.808	2023-03-24 18:03:29.808
94fdf7fc-2893-42cc-b3d7-508f71a093cd	1	2	100000	56258c7b-a6bf-4c78-80e2-310a0b941146	2023-03-24 18:03:29.817	2023-03-24 18:03:29.817
90cd20cd-8025-4503-be15-3ef2ef60e190	1	2	100000	847c9b44-395d-43d5-90f4-cdea416c4cb1	2023-03-24 18:03:29.827	2023-03-24 18:03:29.827
c9b59767-d94f-45af-a68f-aa187d19fc5a	1	2	100000	31c628a6-63a8-4d48-a32f-8d70ff243b4f	2023-03-24 18:03:29.834	2023-03-24 18:03:29.834
feaf88d6-9c4a-44cf-bfc5-697530aa0945	1	2	100000	14899068-d2be-4cee-9cbc-ab3ae406c473	2023-03-24 18:03:29.844	2023-03-24 18:03:29.844
f7ec41cd-a038-4a58-b899-aa0008dd8ed0	1	2	100000	a82abf72-d80c-4099-aaef-470ff25f74f8	2023-03-24 18:03:29.852	2023-03-24 18:03:29.852
f9a0d145-8676-4c54-9a07-b9673d4de899	1	2	100000	d4e5888e-1e65-4d2c-890f-6ecb4ff0053c	2023-03-24 18:03:29.863	2023-03-24 18:03:29.863
4424323c-5c6b-4230-b38b-05d5ac3816b4	1	2	100000	47a90be1-6239-43c3-8039-8f6e3aaafb79	2023-03-24 18:03:29.873	2023-03-24 18:03:29.873
8cf6a2f5-b08e-4f42-b826-bf64aaf8a0c4	1	2	100000	4ed9ecf1-8c3a-42d1-a044-14c0644d09e2	2023-03-24 18:03:29.882	2023-03-24 18:03:29.882
7c9c9c4a-22e8-4159-94f6-3fc49b6db53d	1	2	100000	a59fdb1b-20b8-4787-b037-b4c7d063867d	2023-03-24 18:03:29.936	2023-03-24 18:03:29.936
1b0685b7-ae04-470f-8dce-49f963627853	1	2	100000	d0b19555-f46b-4ea7-96de-ebca0fd8db32	2023-03-24 18:03:29.954	2023-03-24 18:03:29.954
9c72b069-917a-4030-9d2e-ec9ec956e5f4	1	2	100000	ad64b9b0-98b5-4b69-b88e-e600fee48bed	2023-03-24 18:03:29.982	2023-03-24 18:03:29.982
7e86981d-7618-441c-ae85-11e7cb3c2b69	1	2	100000	33d101aa-6867-4149-99ab-878b2e088115	2023-03-24 18:03:29.992	2023-03-24 18:03:29.992
31a6b966-27c6-47d1-9145-72a5c3e59918	1	2	100000	8d779087-cc37-47a8-9b69-991ed819f398	2023-03-24 18:03:30.004	2023-03-24 18:03:30.004
ecdf9a1b-2f13-420f-914d-c3aea0f1d7c0	1	2	100000	6fe2ccaf-8911-49c3-8d1d-41bdf6f0b019	2023-03-24 18:03:30.026	2023-03-24 18:03:30.026
292ed744-e96a-48af-8e34-56a955f383c1	1	2	100000	5a150c6e-65c0-482f-819a-3b3e0b4db770	2023-03-24 18:03:30.056	2023-03-24 18:03:30.056
06720633-7803-4c50-b601-63fe45592b76	1	2	100000	672e0f91-1a66-4a05-a614-076179532d30	2023-03-24 18:03:30.09	2023-03-24 18:03:30.09
e8caeb42-cab3-4bdb-a9db-4ab276a35558	1	2	100000	84f55ba3-2a76-4bbd-bf50-481a0d9884b2	2023-03-24 18:03:30.102	2023-03-24 18:03:30.102
b8c71119-5c15-4efb-ad69-02acaef5ceb4	1	2	100000	43900fc2-65fb-4d28-bad7-2371c2acb3df	2023-03-24 18:03:30.107	2023-03-24 18:03:30.107
a8c9d736-044f-499c-81ae-34842f15e8d9	1	2	100000	e78431bd-ac5a-4c43-976e-a221089ba775	2023-03-24 18:03:30.155	2023-03-24 18:03:30.155
a35bb883-69e2-45a3-98b5-9be3dd7abc99	1	2	100000	2d40ba5b-d1e4-4eef-91ea-2b42813e1f3f	2023-03-24 18:03:30.186	2023-03-24 18:03:30.186
e39c23c4-cb73-4894-8e59-909e0e664657	1	2	100000	1d418da6-7840-4db4-b346-d93c5b4c72ec	2023-03-24 18:03:30.193	2023-03-24 18:03:30.193
ec1c24d5-4890-442c-aff7-d01ebc8db6d4	1	2	100000	740c3eeb-af9b-4e5c-aebe-15ffd9bbe698	2023-03-24 18:03:30.211	2023-03-24 18:03:30.211
c8e4cc18-39b2-4863-ae96-eb3ad1723af9	1	2	100000	bb427bb5-16d6-45be-9219-af673da92879	2023-03-24 18:03:30.228	2023-03-24 18:03:30.228
5c2cd9f9-3316-408a-b809-4825f75199d6	1	2	100000	33f7c393-31b0-4a60-b999-bf83a35968c7	2023-03-24 18:03:30.235	2023-03-24 18:03:30.235
eacaec04-adf3-427f-9040-8b433ea7a23d	1	2	100000	78b891ea-af71-46a0-9bae-484a2cac0335	2023-03-24 18:03:30.248	2023-03-24 18:03:30.248
3134c817-ccc7-4caf-9d89-2ada69c100db	1	2	100000	c6ebe65a-194f-4e85-bb49-e15d89705677	2023-03-24 18:03:30.258	2023-03-24 18:03:30.258
38920f97-25ea-46db-b435-610e07fab681	1	2	100000	23dabc22-e363-4d28-8be9-450ea93ac194	2023-03-24 18:03:30.286	2023-03-24 18:03:30.286
185e22a4-8a6e-40ba-85a4-2daaf13d4671	1	2	100000	34cf8453-d60e-4aac-a508-32e6fa4b0a45	2023-03-24 18:03:30.33	2023-03-24 18:03:30.33
212340c3-4c23-44d9-a3d1-e6a882102e0e	1	2	100000	0b40373e-963a-4ce7-8a7c-85b58c2eeb2b	2023-03-24 18:03:30.343	2023-03-24 18:03:30.343
c234f21d-9681-43d3-a17f-a1145e2b2b60	1	2	100000	d0ddeff3-e631-438d-909f-ab7f9d05a7af	2023-03-24 18:03:30.356	2023-03-24 18:03:30.356
136857b9-ce12-4a72-830b-cd2063bd61ed	1	2	100000	eaf0a27d-1221-4190-9200-417dd1973833	2023-03-24 18:03:30.375	2023-03-24 18:03:30.375
e8207399-1424-4f91-88a2-b73ba9e21364	1	2	100000	1757aea7-7e07-4a79-85d0-92a92e27571a	2023-03-24 18:03:30.388	2023-03-24 18:03:30.388
bdbadac7-8d6f-4abf-8546-02afef42dd18	1	2	100000	faaeec35-02de-4f2c-b122-d14f5098830f	2023-03-24 18:03:30.401	2023-03-24 18:03:30.401
31352168-ad42-43d3-998d-f58138f71b5a	1	2	100000	6d1858e3-ac0e-4a63-a0c9-1cdfdbefc10a	2023-03-24 18:03:30.484	2023-03-24 18:03:30.484
dbac4795-5f3d-49fb-92fe-2b732cc279a0	1	2	100000	5e80a7d4-ad75-4d2f-9524-0f15436552ad	2023-03-24 18:03:30.52	2023-03-24 18:03:30.52
13702b15-f13c-4ed6-8c06-9fc8e0b53bc5	1	2	100000	062e8bb1-0bff-4063-a666-da5a3a50a668	2023-03-24 18:03:30.592	2023-03-24 18:03:30.592
e761863d-39f6-4192-b0c0-5796fd1b4063	1	2	100000	faba33e6-b41d-4fdf-a6c6-93b77f86bc5b	2023-03-24 18:03:30.627	2023-03-24 18:03:30.627
f7eb15a9-dade-479f-8a02-239b393bbe69	1	2	100000	61147bd9-7701-41da-bfc1-cf66b91ee029	2023-03-24 18:03:30.639	2023-03-24 18:03:30.639
2f2d54e8-fda4-4d65-897b-6c8c248fc1f1	1	2	100000	172802c0-27ac-4224-a3a1-d02693572025	2023-03-24 18:03:30.651	2023-03-24 18:03:30.651
e86d49a9-f5f0-4bd2-ab42-de279d39bf83	1	2	100000	82191f49-87b3-4a56-896f-869a3e6ad49e	2023-03-24 18:03:30.659	2023-03-24 18:03:30.659
2f214256-eb0b-49db-90f6-9092363beef7	1	2	100000	92b6b061-18f3-4b2a-abc0-916aee1e6e7b	2023-03-24 18:03:30.668	2023-03-24 18:03:30.668
89ccbe9a-5383-45cc-af18-10b6c9f9c56c	1	2	100000	b185bd11-bce0-4bfb-a4f2-5f6852e24b59	2023-03-24 18:03:30.686	2023-03-24 18:03:30.686
517a30bb-618c-425b-9213-44890d4cec9c	1	2	100000	e70e48bb-a391-4f47-a82e-fe829d1b98f5	2023-03-24 18:03:30.693	2023-03-24 18:03:30.693
d9c645db-cf8f-4321-93d1-8c840f777462	1	2	100000	332d4983-ffae-4dac-876e-4d86743c1b25	2023-03-24 18:03:30.702	2023-03-24 18:03:30.702
be0b24cb-ccef-41d7-8113-4d8885532101	1	2	100000	5883cbba-b8ac-4fb7-96e6-aa318ee73d90	2023-03-24 18:03:30.71	2023-03-24 18:03:30.71
c393d4bd-0f1c-47ee-8233-716f57a81e07	1	2	100000	6e836e15-3511-4b5a-ac9d-ee26412f381f	2023-03-24 18:03:30.716	2023-03-24 18:03:30.716
f012a752-b83c-4cae-9b69-02bd3b208368	1	2	100000	397b540f-02b4-4973-abd4-b15c26dabbe4	2023-03-24 18:03:30.726	2023-03-24 18:03:30.726
486f953d-3548-4d68-9cf3-a1bac608db92	1	2	100000	d8f63525-be32-4d33-a289-0d74454b8446	2023-03-24 18:03:30.773	2023-03-24 18:03:30.773
c3e98f42-e984-4d15-baa9-570dfc1c96c8	1	2	100000	1eb2ebff-46df-4318-8576-68bca368fb7a	2023-03-24 18:03:30.792	2023-03-24 18:03:30.792
07829cd4-22d9-43aa-bd53-e7fa854e978a	1	2	100000	5c824c54-b625-41ba-800b-569a324d9330	2023-03-24 18:03:30.81	2023-03-24 18:03:30.81
4d935c4e-d05e-4be3-8092-6adcb5020788	1	2	100000	9276e06e-d1e1-4dac-a365-020cf2ee2ad4	2023-03-24 18:03:30.821	2023-03-24 18:03:30.821
a6a93a59-ff61-4e6e-aa4a-407c20516254	1	2	100000	04ec782f-1d50-44a9-a943-c94310cfd30f	2023-03-24 18:03:30.833	2023-03-24 18:03:30.833
a826498b-377d-4c86-af60-7e84ed3c56e7	1	2	100000	f6004e34-e1ee-4f64-b869-ffcee06d3cdc	2023-03-24 18:03:30.845	2023-03-24 18:03:30.845
1ebefbcc-17d7-4e61-b236-46e21bd87107	1	2	100000	b0a379b6-be02-461d-bc10-337027334944	2023-03-24 18:03:30.906	2023-03-24 18:03:30.906
58557406-ba5c-4b43-92f6-ef36ebe95f40	1	2	100000	4b25c4c6-f9fa-479e-b60a-0676ab3daf31	2023-03-24 18:03:30.936	2023-03-24 18:03:30.936
94f43eec-11e1-48c0-9836-e258d98a3c4b	1	2	100000	0ee55124-e1b4-47c2-9768-a09a76aaa822	2023-03-24 18:03:30.953	2023-03-24 18:03:30.953
9da81b48-0d30-4154-a4cd-f0d453263ddb	1	2	100000	c44dd0bb-adf0-4387-9331-3aec474f124b	2023-03-24 18:03:30.974	2023-03-24 18:03:30.974
94118dfc-58bd-4143-94c7-d8c6ec573dac	1	2	100000	0d33f7e9-a80a-4927-a7f0-c6be670b2f74	2023-03-24 18:03:30.998	2023-03-24 18:03:30.998
a148b319-e081-4d56-b4e9-55afa89c6688	1	2	100000	4dde4b4e-7079-4603-a1db-e43bdf59d12b	2023-03-24 18:03:31.006	2023-03-24 18:03:31.006
07889ce1-5d59-4e89-822e-6d5de8fe350a	1	2	100000	6d6a3915-4f87-49c0-9050-80351256976d	2023-03-24 18:03:31.014	2023-03-24 18:03:31.014
16c2c496-b94a-4ef1-bed1-3b6e727351b7	1	2	100000	6398d8fd-e173-4751-ab95-7e03ba3ee868	2023-03-24 18:03:31.023	2023-03-24 18:03:31.023
41659feb-673c-47bb-afe1-8cc6413640cb	1	2	100000	243ebac3-bd83-4a4a-b9ee-41b90e550d37	2023-03-24 18:03:31.031	2023-03-24 18:03:31.031
f892af09-aeee-4316-9422-7c9456a436d2	1	2	100000	f69b17dd-545d-436c-a1eb-6355fdaf3ffb	2023-03-24 18:03:31.041	2023-03-24 18:03:31.041
2411fab8-4ebc-4d36-80c3-5ec5b8d59e99	1	2	100000	9c9b35a8-982d-47cd-89df-9f34e687e4fc	2023-03-24 18:03:31.047	2023-03-24 18:03:31.047
cdc0bc04-edb0-488f-9418-fa996cf55114	1	2	100000	86628d1e-cff0-4a7a-8e36-d19b47358e92	2023-03-24 18:03:31.053	2023-03-24 18:03:31.053
430fa799-765b-44e7-b9a3-d25a04bcca4c	1	2	100000	0d2b7b89-bf26-4f39-84d3-ee91f18bac2e	2023-03-24 18:03:31.106	2023-03-24 18:03:31.106
1e772921-7bca-40ca-807c-2c54d5547404	1	2	100000	5df3ee26-a777-4716-b201-e93ccd7fa64a	2023-03-24 18:03:31.117	2023-03-24 18:03:31.117
890a2e1e-1e86-42b1-908b-af0e8ae65e4b	1	2	100000	8a2f711b-8654-44aa-b9e8-527b1e2fe9b5	2023-03-24 18:03:31.124	2023-03-24 18:03:31.124
54039cea-f556-4d5b-9358-829cb7320aa6	1	2	100000	c8717ce0-0a07-4f3c-a379-9ca44fccfb39	2023-03-24 18:03:31.133	2023-03-24 18:03:31.133
5da59f9e-143e-4028-9f9c-a1da309ec49f	1	2	100000	9ec5af91-84e8-4414-a124-71c15c5a18d8	2023-03-24 18:03:31.148	2023-03-24 18:03:31.148
e09e445d-9e33-453d-a427-e858eb3904da	1	2	100000	bf73fca8-5814-4485-b4d0-cdcf34e0bfa4	2023-03-24 18:03:31.165	2023-03-24 18:03:31.165
0a47ae1b-1b8e-407b-8fd3-bc144c441fa4	1	2	100000	a51d29c4-4f54-434a-87d7-f5a408881f48	2023-03-24 18:03:31.181	2023-03-24 18:03:31.181
525e6e1a-85f9-4d2c-b51d-74e08e41455d	1	2	100000	90e9d1bd-22bb-4452-8a44-aa3e85051d68	2023-03-24 18:03:31.198	2023-03-24 18:03:31.198
b53eca8b-1bc5-44be-9657-73f7b499b568	1	2	100000	66f2f1a2-b204-4ca7-8903-afb8e314e86d	2023-03-24 18:03:31.225	2023-03-24 18:03:31.225
85ec691a-4640-481c-aab0-385feec270e2	1	2	100000	5bd68116-d7b0-4c2e-a355-b214fe8288eb	2023-03-24 18:03:31.249	2023-03-24 18:03:31.249
b4d1b6a4-1e08-45f6-bb3b-49dea872f86d	1	2	100000	98dbb2c7-912f-4e75-b927-8a46cd1658ce	2023-03-24 18:03:31.285	2023-03-24 18:03:31.285
dbadceae-4dfb-4e66-87a8-124bc8147aea	1	2	100000	1681b7fd-1ca8-4c7d-8b0c-982a238ba99e	2023-03-24 18:03:31.31	2023-03-24 18:03:31.31
8534fa27-32aa-4777-b9c3-997efc65d1d1	1	2	100000	0baac6ed-e780-4cc1-a5cd-8ced30f736e5	2023-03-24 18:03:31.351	2023-03-24 18:03:31.351
947ce542-51f9-4a8d-ad0b-8ab143117fb7	1	2	100000	a65e328e-96b1-4ef3-a65a-385899998cc5	2023-03-24 18:03:31.382	2023-03-24 18:03:31.382
3a77c035-5c5c-42a6-b5e1-49e0ea8c8afd	1	2	100000	bdbd8eab-eb0d-4b93-a917-ba46d93d4bf3	2023-03-24 18:03:31.407	2023-03-24 18:03:31.407
\.


--
-- TOC entry 3463 (class 0 OID 16443)
-- Dependencies: 218
-- Data for Name: Vote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Vote" (id, "themeId", "userId", "createdAt", "updatedAt") FROM stdin;
bd1432aa-1f3a-4acd-ac99-e5d18d3f2fab	588e58a5-1783-455a-86c3-25ed89a6b71e	3df7c44f-f62e-4279-80c2-bca753102fac	2023-03-24 18:03:29.332	2023-03-24 18:03:29.332
40bdd94c-ea4b-4871-ae57-3ab88692a137	588e58a5-1783-455a-86c3-25ed89a6b71e	741f081e-6a83-4c81-a505-a1ff5433c69f	2023-03-24 18:03:29.332	2023-03-24 18:03:29.332
64ae4501-607e-4d51-bbb7-1bd4905f1624	588e58a5-1783-455a-86c3-25ed89a6b71e	66e7c0a8-fda9-4c04-8edf-fe9047608265	2023-03-24 18:03:29.332	2023-03-24 18:03:29.332
878d9661-afdf-4ae2-9194-34e569be80e6	588e58a5-1783-455a-86c3-25ed89a6b71e	27d95f2d-2d45-4a88-9f6f-cd21e0182caf	2023-03-24 18:03:29.332	2023-03-24 18:03:29.332
6261aa24-f461-4208-8e6a-38c3e8ae9c9b	60b840c6-79b6-47a6-b365-1700d1192e49	3df7c44f-f62e-4279-80c2-bca753102fac	2023-03-24 18:03:29.895	2023-03-24 18:03:29.895
46be8b30-e776-48e0-9e07-13ae6c2ff0ea	60b840c6-79b6-47a6-b365-1700d1192e49	741f081e-6a83-4c81-a505-a1ff5433c69f	2023-03-24 18:03:29.895	2023-03-24 18:03:29.895
39c16dca-7d78-45f1-984f-8b4ff56000ef	60b840c6-79b6-47a6-b365-1700d1192e49	66e7c0a8-fda9-4c04-8edf-fe9047608265	2023-03-24 18:03:29.895	2023-03-24 18:03:29.895
c1968a4e-946c-4c1d-b486-618322cf0d1d	60b840c6-79b6-47a6-b365-1700d1192e49	27d95f2d-2d45-4a88-9f6f-cd21e0182caf	2023-03-24 18:03:29.895	2023-03-24 18:03:29.895
7d28e0e1-c4e4-43b4-934a-05dd13865644	3b1a0617-1149-42d4-ada3-4044f12717cf	3df7c44f-f62e-4279-80c2-bca753102fac	2023-03-24 18:03:30.301	2023-03-24 18:03:30.301
5974d549-cb22-4a51-abf3-9116cc8343fb	3b1a0617-1149-42d4-ada3-4044f12717cf	741f081e-6a83-4c81-a505-a1ff5433c69f	2023-03-24 18:03:30.301	2023-03-24 18:03:30.301
a4431282-339b-4418-8e49-b1c470dce4d5	3b1a0617-1149-42d4-ada3-4044f12717cf	66e7c0a8-fda9-4c04-8edf-fe9047608265	2023-03-24 18:03:30.301	2023-03-24 18:03:30.301
48cc6bcf-dea4-4071-90b4-e399e69162a3	3b1a0617-1149-42d4-ada3-4044f12717cf	27d95f2d-2d45-4a88-9f6f-cd21e0182caf	2023-03-24 18:03:30.301	2023-03-24 18:03:30.301
862bcbb0-4b71-4b9e-b687-9d7d94afe7dd	1fba486c-0fbf-4488-a3ce-d4d144688002	3df7c44f-f62e-4279-80c2-bca753102fac	2023-03-24 18:03:30.74	2023-03-24 18:03:30.74
941ff5c7-40c5-4dfb-a7e1-8fb91c98b83c	1fba486c-0fbf-4488-a3ce-d4d144688002	741f081e-6a83-4c81-a505-a1ff5433c69f	2023-03-24 18:03:30.74	2023-03-24 18:03:30.74
a19084f6-7043-4de0-9a7a-8fe824ad6ece	1fba486c-0fbf-4488-a3ce-d4d144688002	66e7c0a8-fda9-4c04-8edf-fe9047608265	2023-03-24 18:03:30.74	2023-03-24 18:03:30.74
367e446b-e955-4532-89f7-a62b06d416e4	1fba486c-0fbf-4488-a3ce-d4d144688002	27d95f2d-2d45-4a88-9f6f-cd21e0182caf	2023-03-24 18:03:30.74	2023-03-24 18:03:30.74
7c0c8128-b424-455c-a775-2cb61f8774b2	33cee886-1cc3-41b8-8859-01af609a507a	3df7c44f-f62e-4279-80c2-bca753102fac	2023-03-24 18:03:31.071	2023-03-24 18:03:31.071
c12b6773-0120-497d-9cc7-d7b20217ec34	33cee886-1cc3-41b8-8859-01af609a507a	741f081e-6a83-4c81-a505-a1ff5433c69f	2023-03-24 18:03:31.071	2023-03-24 18:03:31.071
83d674fb-87b0-419e-a18b-668a1f22bb46	33cee886-1cc3-41b8-8859-01af609a507a	66e7c0a8-fda9-4c04-8edf-fe9047608265	2023-03-24 18:03:31.071	2023-03-24 18:03:31.071
2922489e-03eb-4ef9-989b-0d89af91ec8b	33cee886-1cc3-41b8-8859-01af609a507a	27d95f2d-2d45-4a88-9f6f-cd21e0182caf	2023-03-24 18:03:31.071	2023-03-24 18:03:31.071
\.


--
-- TOC entry 3459 (class 0 OID 16390)
-- Dependencies: 214
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
e7b3f850-d19e-43e7-9da0-3da294ad945e	a87bfb6a6213e618529c1c27700a56d5bde46f2a928dd12a0c67a39218102f1d	2023-03-24 18:03:26.596751+00	20221229124613_init	\N	\N	2023-03-24 18:03:26.570445+00	1
9dcf474f-13e8-410c-b941-55424c15927a	7b0369c42935230cc1dd2cd5b4a2216dd398f90e24df068f06498050f28445b2	2023-03-24 18:03:26.601039+00	20230301075559_qualification_occurence	\N	\N	2023-03-24 18:03:26.597911+00	1
f636cbd4-ed49-4d7e-85ee-7a44e6db812b	44aaffef18e6a2888f83743b0d3514d28f4d40e98a9b9c557c110960f272bfba	2023-03-24 18:03:26.619915+00	20230317161905_rework	\N	\N	2023-03-24 18:03:26.60229+00	1
\.


--
-- TOC entry 3292 (class 2606 OID 16567)
-- Name: AnswerTranslation AnswerTranslation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerTranslation"
    ADD CONSTRAINT "AnswerTranslation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 16468)
-- Name: Answer Answer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_pkey" PRIMARY KEY (id);


--
-- TOC entry 3296 (class 2606 OID 16586)
-- Name: Language Language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Language"
    ADD CONSTRAINT "Language_pkey" PRIMARY KEY (id);


--
-- TOC entry 3294 (class 2606 OID 16577)
-- Name: QualificationTranslation QualificationTranslation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QualificationTranslation"
    ADD CONSTRAINT "QualificationTranslation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 16477)
-- Name: Qualification Qualification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Qualification"
    ADD CONSTRAINT "Qualification_pkey" PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 16557)
-- Name: QuestionTranslation QuestionTranslation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTranslation"
    ADD CONSTRAINT "QuestionTranslation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3279 (class 2606 OID 16459)
-- Name: Question Question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_pkey" PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 16423)
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 16547)
-- Name: ThemeTranslation ThemeTranslation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThemeTranslation"
    ADD CONSTRAINT "ThemeTranslation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3275 (class 2606 OID 16442)
-- Name: Theme Theme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Theme"
    ADD CONSTRAINT "Theme_pkey" PRIMARY KEY (id);


--
-- TOC entry 3273 (class 2606 OID 16432)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 16484)
-- Name: Validation Validation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Validation"
    ADD CONSTRAINT "Validation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3277 (class 2606 OID 16449)
-- Name: Vote Vote_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_pkey" PRIMARY KEY (id);


--
-- TOC entry 3268 (class 2606 OID 16398)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3271 (class 1259 OID 16485)
-- Name: Role_role_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Role_role_key" ON public."Role" USING btree (role);


--
-- TOC entry 3284 (class 1259 OID 16486)
-- Name: Validation_answerId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Validation_answerId_key" ON public."Validation" USING btree ("answerId");


--
-- TOC entry 3313 (class 2606 OID 16622)
-- Name: AnswerTranslation AnswerTranslation_answerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerTranslation"
    ADD CONSTRAINT "AnswerTranslation_answerId_fkey" FOREIGN KEY ("answerId") REFERENCES public."Answer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3314 (class 2606 OID 16617)
-- Name: AnswerTranslation AnswerTranslation_languageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerTranslation"
    ADD CONSTRAINT "AnswerTranslation_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3305 (class 2606 OID 16517)
-- Name: Answer Answer_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3306 (class 2606 OID 16522)
-- Name: Answer Answer_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Answer"
    ADD CONSTRAINT "Answer_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3315 (class 2606 OID 16627)
-- Name: QualificationTranslation QualificationTranslation_languageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QualificationTranslation"
    ADD CONSTRAINT "QualificationTranslation_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3316 (class 2606 OID 16632)
-- Name: QualificationTranslation QualificationTranslation_qualificationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QualificationTranslation"
    ADD CONSTRAINT "QualificationTranslation_qualificationId_fkey" FOREIGN KEY ("qualificationId") REFERENCES public."Qualification"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3307 (class 2606 OID 16527)
-- Name: Qualification Qualification_answerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Qualification"
    ADD CONSTRAINT "Qualification_answerId_fkey" FOREIGN KEY ("answerId") REFERENCES public."Answer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3311 (class 2606 OID 16607)
-- Name: QuestionTranslation QuestionTranslation_languageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTranslation"
    ADD CONSTRAINT "QuestionTranslation_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3312 (class 2606 OID 16612)
-- Name: QuestionTranslation QuestionTranslation_questionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTranslation"
    ADD CONSTRAINT "QuestionTranslation_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES public."Question"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3303 (class 2606 OID 16512)
-- Name: Question Question_themeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_themeId_fkey" FOREIGN KEY ("themeId") REFERENCES public."Theme"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3304 (class 2606 OID 16507)
-- Name: Question Question_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Question"
    ADD CONSTRAINT "Question_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3309 (class 2606 OID 16597)
-- Name: ThemeTranslation ThemeTranslation_languageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThemeTranslation"
    ADD CONSTRAINT "ThemeTranslation_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3310 (class 2606 OID 16602)
-- Name: ThemeTranslation ThemeTranslation_themeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThemeTranslation"
    ADD CONSTRAINT "ThemeTranslation_themeId_fkey" FOREIGN KEY ("themeId") REFERENCES public."Theme"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3300 (class 2606 OID 16492)
-- Name: Theme Theme_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Theme"
    ADD CONSTRAINT "Theme_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3297 (class 2606 OID 16587)
-- Name: User User_commonLanguageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_commonLanguageId_fkey" FOREIGN KEY ("commonLanguageId") REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3298 (class 2606 OID 16592)
-- Name: User User_culturalLanguageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_culturalLanguageId_fkey" FOREIGN KEY ("culturalLanguageId") REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3299 (class 2606 OID 16487)
-- Name: User User_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3308 (class 2606 OID 16532)
-- Name: Validation Validation_answerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Validation"
    ADD CONSTRAINT "Validation_answerId_fkey" FOREIGN KEY ("answerId") REFERENCES public."Answer"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3301 (class 2606 OID 16497)
-- Name: Vote Vote_themeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_themeId_fkey" FOREIGN KEY ("themeId") REFERENCES public."Theme"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3302 (class 2606 OID 16502)
-- Name: Vote Vote_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2023-03-27 11:02:08 CEST

--
-- PostgreSQL database dump complete
--

