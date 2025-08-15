


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


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."cube_dependencies" (
    "id" bigint NOT NULL,
    "parent_cube_id" bigint NOT NULL,
    "child_cube_id" bigint NOT NULL
);


ALTER TABLE "public"."cube_dependencies" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."cube_dependencies_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."cube_dependencies_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."cube_dependencies_id_seq" OWNED BY "public"."cube_dependencies"."id";



CREATE TABLE IF NOT EXISTS "public"."cubes" (
    "id" bigint NOT NULL,
    "tab_id" bigint NOT NULL,
    "type" "text" NOT NULL,
    "name" "text" NOT NULL,
    "data" "text",
    "sheet_data" "jsonb",
    "position_x" integer DEFAULT 0,
    "position_y" integer DEFAULT 0,
    "width" integer DEFAULT 640,
    "height" integer DEFAULT 360,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "cubes_type_check" CHECK (("type" = ANY (ARRAY['source'::"text", 'query'::"text"])))
);


ALTER TABLE "public"."cubes" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."cubes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."cubes_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."cubes_id_seq" OWNED BY "public"."cubes"."id";



CREATE TABLE IF NOT EXISTS "public"."projects" (
    "id" bigint NOT NULL,
    "user_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."projects" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."projects_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."projects_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."projects_id_seq" OWNED BY "public"."projects"."id";



CREATE TABLE IF NOT EXISTS "public"."tabs" (
    "id" bigint NOT NULL,
    "project_id" bigint NOT NULL,
    "title" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."tabs" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."tabs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."tabs_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."tabs_id_seq" OWNED BY "public"."tabs"."id";



ALTER TABLE ONLY "public"."cube_dependencies" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cube_dependencies_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."cubes" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cubes_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."projects" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."projects_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."tabs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tabs_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."cube_dependencies"
    ADD CONSTRAINT "cube_dependencies_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cubes"
    ADD CONSTRAINT "cubes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."projects"
    ADD CONSTRAINT "projects_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tabs"
    ADD CONSTRAINT "tabs_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_cubes_tab_id" ON "public"."cubes" USING "btree" ("tab_id");



CREATE INDEX "idx_tabs_project_id" ON "public"."tabs" USING "btree" ("project_id");



CREATE UNIQUE INDEX "ux_cube_deps_parent_child" ON "public"."cube_dependencies" USING "btree" ("parent_cube_id", "child_cube_id");



ALTER TABLE ONLY "public"."cube_dependencies"
    ADD CONSTRAINT "cube_dependencies_child_cube_id_fkey" FOREIGN KEY ("child_cube_id") REFERENCES "public"."cubes"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."cube_dependencies"
    ADD CONSTRAINT "cube_dependencies_parent_cube_id_fkey" FOREIGN KEY ("parent_cube_id") REFERENCES "public"."cubes"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."cubes"
    ADD CONSTRAINT "cubes_tab_id_fkey" FOREIGN KEY ("tab_id") REFERENCES "public"."tabs"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."projects"
    ADD CONSTRAINT "projects_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tabs"
    ADD CONSTRAINT "tabs_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "public"."projects"("id") ON DELETE CASCADE;





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";








































































































































































GRANT ALL ON TABLE "public"."cube_dependencies" TO "anon";
GRANT ALL ON TABLE "public"."cube_dependencies" TO "authenticated";
GRANT ALL ON TABLE "public"."cube_dependencies" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cube_dependencies_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cube_dependencies_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cube_dependencies_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."cubes" TO "anon";
GRANT ALL ON TABLE "public"."cubes" TO "authenticated";
GRANT ALL ON TABLE "public"."cubes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cubes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cubes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cubes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."projects" TO "anon";
GRANT ALL ON TABLE "public"."projects" TO "authenticated";
GRANT ALL ON TABLE "public"."projects" TO "service_role";



GRANT ALL ON SEQUENCE "public"."projects_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."projects_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."projects_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tabs" TO "anon";
GRANT ALL ON TABLE "public"."tabs" TO "authenticated";
GRANT ALL ON TABLE "public"."tabs" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tabs_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tabs_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tabs_id_seq" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






























RESET ALL;
