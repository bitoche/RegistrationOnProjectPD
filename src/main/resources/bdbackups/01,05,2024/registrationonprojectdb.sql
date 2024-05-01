PGDMP  2    #                |            registrationonprojectdb    15.6    16.2 b    y           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            z           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            {           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            |           1262    16394    registrationonprojectdb    DATABASE     �   CREATE DATABASE registrationonprojectdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
 '   DROP DATABASE registrationonprojectdb;
                postgres    false            �            1259    16395    app_user    TABLE     0  CREATE TABLE public.app_user (
    id bigint NOT NULL,
    birth_date date,
    login character varying(255),
    name character varying(255),
    password character varying(255),
    patronymic character varying(255),
    role smallint,
    surname character varying(255),
    study_group_id integer
);
    DROP TABLE public.app_user;
       public         heap    postgres    false            �            1259    16400    app_user_id_seq    SEQUENCE     x   CREATE SEQUENCE public.app_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.app_user_id_seq;
       public          postgres    false    214            }           0    0    app_user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.app_user_id_seq OWNED BY public.app_user.id;
          public          postgres    false    215            �            1259    16401    study_group    TABLE     r   CREATE TABLE public.study_group (
    id integer NOT NULL,
    name character varying(255),
    course integer
);
    DROP TABLE public.study_group;
       public         heap    postgres    false            �            1259    16404    study_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.study_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.study_group_id_seq;
       public          postgres    false    216            ~           0    0    study_group_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.study_group_id_seq OWNED BY public.study_group.id;
          public          postgres    false    217            �            1259    16405    team    TABLE     k   CREATE TABLE public.team (
    id bigint NOT NULL,
    name character varying(255),
    topic_id bigint
);
    DROP TABLE public.team;
       public         heap    postgres    false            �            1259    16408    team_id_seq    SEQUENCE     t   CREATE SEQUENCE public.team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.team_id_seq;
       public          postgres    false    218                       0    0    team_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;
          public          postgres    false    219            �            1259    16409    team_member    TABLE     �   CREATE TABLE public.team_member (
    id bigint NOT NULL,
    date timestamp(6) without time zone,
    role smallint,
    member_id bigint,
    CONSTRAINT team_member_role_check CHECK (((role >= 0) AND (role <= 2)))
);
    DROP TABLE public.team_member;
       public         heap    postgres    false            �            1259    16413    team_member_id_seq    SEQUENCE     {   CREATE SEQUENCE public.team_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.team_member_id_seq;
       public          postgres    false    220            �           0    0    team_member_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.team_member_id_seq OWNED BY public.team_member.id;
          public          postgres    false    221            �            1259    16414    team_members    TABLE     b   CREATE TABLE public.team_members (
    team_id bigint NOT NULL,
    members_id bigint NOT NULL
);
     DROP TABLE public.team_members;
       public         heap    postgres    false            �            1259    16417    team_request    TABLE     �   CREATE TABLE public.team_request (
    id bigint NOT NULL,
    date timestamp(6) without time zone,
    requesting_user_id bigint,
    team_id bigint
);
     DROP TABLE public.team_request;
       public         heap    postgres    false            �            1259    16420    team_request_id_seq    SEQUENCE     |   CREATE SEQUENCE public.team_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.team_request_id_seq;
       public          postgres    false    223            �           0    0    team_request_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.team_request_id_seq OWNED BY public.team_request.id;
          public          postgres    false    224            �            1259    16421    topic    TABLE     �   CREATE TABLE public.topic (
    id bigint NOT NULL,
    adding_date timestamp(6) without time zone,
    description character varying(2048),
    name character varying(255),
    approved_user_id bigint,
    adding_request_id bigint
);
    DROP TABLE public.topic;
       public         heap    postgres    false            �            1259    16426    topic_create_request    TABLE     �   CREATE TABLE public.topic_create_request (
    id bigint NOT NULL,
    request_date timestamp(6) without time zone,
    topic_description character varying(2048),
    topic_name character varying(255),
    requesting_user_id bigint
);
 (   DROP TABLE public.topic_create_request;
       public         heap    postgres    false            �            1259    16431    topic_create_request_id_seq    SEQUENCE     �   CREATE SEQUENCE public.topic_create_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.topic_create_request_id_seq;
       public          postgres    false    226            �           0    0    topic_create_request_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.topic_create_request_id_seq OWNED BY public.topic_create_request.id;
          public          postgres    false    227            �            1259    16432    topic_create_request_status    TABLE     �   CREATE TABLE public.topic_create_request_status (
    id bigint NOT NULL,
    comment character varying(255),
    date timestamp(6) without time zone,
    status smallint,
    request_id bigint
);
 /   DROP TABLE public.topic_create_request_status;
       public         heap    postgres    false            �            1259    16436 "   topic_create_request_status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.topic_create_request_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.topic_create_request_status_id_seq;
       public          postgres    false    228            �           0    0 "   topic_create_request_status_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.topic_create_request_status_id_seq OWNED BY public.topic_create_request_status.id;
          public          postgres    false    229            �            1259    16437    topic_id_seq    SEQUENCE     u   CREATE SEQUENCE public.topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.topic_id_seq;
       public          postgres    false    225            �           0    0    topic_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.topic_id_seq OWNED BY public.topic.id;
          public          postgres    false    230            �            1259    16438    topic_request    TABLE     r   CREATE TABLE public.topic_request (
    id bigint NOT NULL,
    requesting_team_id bigint,
    topic_id bigint
);
 !   DROP TABLE public.topic_request;
       public         heap    postgres    false            �            1259    16441    topic_request_id_seq    SEQUENCE     }   CREATE SEQUENCE public.topic_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.topic_request_id_seq;
       public          postgres    false    231            �           0    0    topic_request_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.topic_request_id_seq OWNED BY public.topic_request.id;
          public          postgres    false    232            �            1259    16442    topic_request_status    TABLE     (  CREATE TABLE public.topic_request_status (
    id bigint NOT NULL,
    comment character varying(255),
    status smallint,
    status_date timestamp(6) without time zone,
    reviewed_admin_id bigint,
    CONSTRAINT topic_request_status_status_check CHECK (((status >= 0) AND (status <= 3)))
);
 (   DROP TABLE public.topic_request_status;
       public         heap    postgres    false            �            1259    16446    topic_request_status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.topic_request_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.topic_request_status_id_seq;
       public          postgres    false    233            �           0    0    topic_request_status_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.topic_request_status_id_seq OWNED BY public.topic_request_status.id;
          public          postgres    false    234            �           2604    16581    app_user id    DEFAULT     j   ALTER TABLE ONLY public.app_user ALTER COLUMN id SET DEFAULT nextval('public.app_user_id_seq'::regclass);
 :   ALTER TABLE public.app_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214            �           2604    16582    study_group id    DEFAULT     p   ALTER TABLE ONLY public.study_group ALTER COLUMN id SET DEFAULT nextval('public.study_group_id_seq'::regclass);
 =   ALTER TABLE public.study_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216            �           2604    16583    team id    DEFAULT     b   ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);
 6   ALTER TABLE public.team ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218            �           2604    16584    team_member id    DEFAULT     p   ALTER TABLE ONLY public.team_member ALTER COLUMN id SET DEFAULT nextval('public.team_member_id_seq'::regclass);
 =   ALTER TABLE public.team_member ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220            �           2604    16585    team_request id    DEFAULT     r   ALTER TABLE ONLY public.team_request ALTER COLUMN id SET DEFAULT nextval('public.team_request_id_seq'::regclass);
 >   ALTER TABLE public.team_request ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    16586    topic id    DEFAULT     d   ALTER TABLE ONLY public.topic ALTER COLUMN id SET DEFAULT nextval('public.topic_id_seq'::regclass);
 7   ALTER TABLE public.topic ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    225            �           2604    16587    topic_create_request id    DEFAULT     �   ALTER TABLE ONLY public.topic_create_request ALTER COLUMN id SET DEFAULT nextval('public.topic_create_request_id_seq'::regclass);
 F   ALTER TABLE public.topic_create_request ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226            �           2604    16588    topic_create_request_status id    DEFAULT     �   ALTER TABLE ONLY public.topic_create_request_status ALTER COLUMN id SET DEFAULT nextval('public.topic_create_request_status_id_seq'::regclass);
 M   ALTER TABLE public.topic_create_request_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228            �           2604    16589    topic_request id    DEFAULT     t   ALTER TABLE ONLY public.topic_request ALTER COLUMN id SET DEFAULT nextval('public.topic_request_id_seq'::regclass);
 ?   ALTER TABLE public.topic_request ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231            �           2604    16590    topic_request_status id    DEFAULT     �   ALTER TABLE ONLY public.topic_request_status ALTER COLUMN id SET DEFAULT nextval('public.topic_request_status_id_seq'::regclass);
 F   ALTER TABLE public.topic_request_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233            b          0    16395    app_user 
   TABLE DATA           t   COPY public.app_user (id, birth_date, login, name, password, patronymic, role, surname, study_group_id) FROM stdin;
    public          postgres    false    214   xw       d          0    16401    study_group 
   TABLE DATA           7   COPY public.study_group (id, name, course) FROM stdin;
    public          postgres    false    216   �z       f          0    16405    team 
   TABLE DATA           2   COPY public.team (id, name, topic_id) FROM stdin;
    public          postgres    false    218   �z       h          0    16409    team_member 
   TABLE DATA           @   COPY public.team_member (id, date, role, member_id) FROM stdin;
    public          postgres    false    220   6{       j          0    16414    team_members 
   TABLE DATA           ;   COPY public.team_members (team_id, members_id) FROM stdin;
    public          postgres    false    222   �{       k          0    16417    team_request 
   TABLE DATA           M   COPY public.team_request (id, date, requesting_user_id, team_id) FROM stdin;
    public          postgres    false    223   �{       m          0    16421    topic 
   TABLE DATA           h   COPY public.topic (id, adding_date, description, name, approved_user_id, adding_request_id) FROM stdin;
    public          postgres    false    225   �{       n          0    16426    topic_create_request 
   TABLE DATA           s   COPY public.topic_create_request (id, request_date, topic_description, topic_name, requesting_user_id) FROM stdin;
    public          postgres    false    226   �}       p          0    16432    topic_create_request_status 
   TABLE DATA           \   COPY public.topic_create_request_status (id, comment, date, status, request_id) FROM stdin;
    public          postgres    false    228   =�       s          0    16438    topic_request 
   TABLE DATA           I   COPY public.topic_request (id, requesting_team_id, topic_id) FROM stdin;
    public          postgres    false    231   p�       u          0    16442    topic_request_status 
   TABLE DATA           c   COPY public.topic_request_status (id, comment, status, status_date, reviewed_admin_id) FROM stdin;
    public          postgres    false    233   ��       �           0    0    app_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.app_user_id_seq', 24, true);
          public          postgres    false    215            �           0    0    study_group_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.study_group_id_seq', 12, true);
          public          postgres    false    217            �           0    0    team_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.team_id_seq', 11, true);
          public          postgres    false    219            �           0    0    team_member_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.team_member_id_seq', 28, true);
          public          postgres    false    221            �           0    0    team_request_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.team_request_id_seq', 10, true);
          public          postgres    false    224            �           0    0    topic_create_request_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.topic_create_request_id_seq', 9, true);
          public          postgres    false    227            �           0    0 "   topic_create_request_status_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.topic_create_request_status_id_seq', 7, true);
          public          postgres    false    229            �           0    0    topic_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.topic_id_seq', 12, true);
          public          postgres    false    230            �           0    0    topic_request_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.topic_request_id_seq', 1, false);
          public          postgres    false    232            �           0    0    topic_request_status_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.topic_request_status_id_seq', 1, false);
          public          postgres    false    234            �           2606    16458    app_user app_user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.app_user DROP CONSTRAINT app_user_pkey;
       public            postgres    false    214            �           2606    16460    app_user login 
   CONSTRAINT     J   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT login UNIQUE (login);
 8   ALTER TABLE ONLY public.app_user DROP CONSTRAINT login;
       public            postgres    false    214            �           2606    16462    study_group study_group_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.study_group
    ADD CONSTRAINT study_group_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.study_group DROP CONSTRAINT study_group_pkey;
       public            postgres    false    216            �           2606    16464    team_member team_member_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT team_member_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.team_member DROP CONSTRAINT team_member_pkey;
       public            postgres    false    220            �           2606    16466    team team_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.team DROP CONSTRAINT team_pkey;
       public            postgres    false    218            �           2606    16468    team_request team_request_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT team_request_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.team_request DROP CONSTRAINT team_request_pkey;
       public            postgres    false    223            �           2606    16470 .   topic_create_request topic_create_request_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.topic_create_request
    ADD CONSTRAINT topic_create_request_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.topic_create_request DROP CONSTRAINT topic_create_request_pkey;
       public            postgres    false    226            �           2606    16472 <   topic_create_request_status topic_create_request_status_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.topic_create_request_status
    ADD CONSTRAINT topic_create_request_status_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.topic_create_request_status DROP CONSTRAINT topic_create_request_status_pkey;
       public            postgres    false    228            �           2606    16474    topic topic_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.topic DROP CONSTRAINT topic_pkey;
       public            postgres    false    225            �           2606    16476     topic_request topic_request_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT topic_request_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT topic_request_pkey;
       public            postgres    false    231            �           2606    16478 .   topic_request_status topic_request_status_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.topic_request_status
    ADD CONSTRAINT topic_request_status_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.topic_request_status DROP CONSTRAINT topic_request_status_pkey;
       public            postgres    false    233            �           2606    16480 )   team_request uk_14e3vm3mavy26x0wochcwc9oy 
   CONSTRAINT     g   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT uk_14e3vm3mavy26x0wochcwc9oy UNIQUE (team_id);
 S   ALTER TABLE ONLY public.team_request DROP CONSTRAINT uk_14e3vm3mavy26x0wochcwc9oy;
       public            postgres    false    223            �           2606    16484 *   topic_request uk_7c65d231oewycbqir69ja9m13 
   CONSTRAINT     i   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT uk_7c65d231oewycbqir69ja9m13 UNIQUE (topic_id);
 T   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT uk_7c65d231oewycbqir69ja9m13;
       public            postgres    false    231            �           2606    16486 )   team_request uk_ae25bnla80wldqco3wp3v9dvu 
   CONSTRAINT     r   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT uk_ae25bnla80wldqco3wp3v9dvu UNIQUE (requesting_user_id);
 S   ALTER TABLE ONLY public.team_request DROP CONSTRAINT uk_ae25bnla80wldqco3wp3v9dvu;
       public            postgres    false    223            �           2606    16488 8   topic_create_request_status uk_bl9mud127j6g44un3madsavv9 
   CONSTRAINT     y   ALTER TABLE ONLY public.topic_create_request_status
    ADD CONSTRAINT uk_bl9mud127j6g44un3madsavv9 UNIQUE (request_id);
 b   ALTER TABLE ONLY public.topic_create_request_status DROP CONSTRAINT uk_bl9mud127j6g44un3madsavv9;
       public            postgres    false    228            �           2606    16490 !   team uk_d8dslqiatvrcpegql28mgo0q6 
   CONSTRAINT     `   ALTER TABLE ONLY public.team
    ADD CONSTRAINT uk_d8dslqiatvrcpegql28mgo0q6 UNIQUE (topic_id);
 K   ALTER TABLE ONLY public.team DROP CONSTRAINT uk_d8dslqiatvrcpegql28mgo0q6;
       public            postgres    false    218            �           2606    16492 *   topic_request uk_gv03u9vs2v384fc46k91jsh63 
   CONSTRAINT     s   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT uk_gv03u9vs2v384fc46k91jsh63 UNIQUE (requesting_team_id);
 T   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT uk_gv03u9vs2v384fc46k91jsh63;
       public            postgres    false    231            �           2606    16494 1   topic_request_status uk_tng3qxm4v92g4mhy0vbg6jmki 
   CONSTRAINT     y   ALTER TABLE ONLY public.topic_request_status
    ADD CONSTRAINT uk_tng3qxm4v92g4mhy0vbg6jmki UNIQUE (reviewed_admin_id);
 [   ALTER TABLE ONLY public.topic_request_status DROP CONSTRAINT uk_tng3qxm4v92g4mhy0vbg6jmki;
       public            postgres    false    233            �           2606    16495 0   topic_create_request fk2609bn7qglsbjl329ygebe9lu    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_create_request
    ADD CONSTRAINT fk2609bn7qglsbjl329ygebe9lu FOREIGN KEY (requesting_user_id) REFERENCES public.app_user(id);
 Z   ALTER TABLE ONLY public.topic_create_request DROP CONSTRAINT fk2609bn7qglsbjl329ygebe9lu;
       public          postgres    false    3235    226    214            �           2606    16505 !   topic fk3q5a0qqdl2xagfb4cb2ykjlp2    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic
    ADD CONSTRAINT fk3q5a0qqdl2xagfb4cb2ykjlp2 FOREIGN KEY (approved_user_id) REFERENCES public.app_user(id);
 K   ALTER TABLE ONLY public.topic DROP CONSTRAINT fk3q5a0qqdl2xagfb4cb2ykjlp2;
       public          postgres    false    3235    214    225            �           2606    16510 )   topic_request fk8tdm7c5mdv5ckm73ynhpg8vv3    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT fk8tdm7c5mdv5ckm73ynhpg8vv3 FOREIGN KEY (requesting_team_id) REFERENCES public.team(id);
 S   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT fk8tdm7c5mdv5ckm73ynhpg8vv3;
       public          postgres    false    218    3241    231            �           2606    16576    team_members fk_child_parent    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT fk_child_parent FOREIGN KEY (members_id) REFERENCES public.team_member(id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.team_members DROP CONSTRAINT fk_child_parent;
       public          postgres    false    220    222    3245            �           2606    16515 0   topic_request_status fkafg54dvkcbjqvqpn8dxmexpvq    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_request_status
    ADD CONSTRAINT fkafg54dvkcbjqvqpn8dxmexpvq FOREIGN KEY (reviewed_admin_id) REFERENCES public.app_user(id);
 Z   ALTER TABLE ONLY public.topic_request_status DROP CONSTRAINT fkafg54dvkcbjqvqpn8dxmexpvq;
       public          postgres    false    3235    214    233            �           2606    16520 (   team_members fkb3toat7ors5scfmd3n69dhmr1    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT fkb3toat7ors5scfmd3n69dhmr1 FOREIGN KEY (team_id) REFERENCES public.team(id);
 R   ALTER TABLE ONLY public.team_members DROP CONSTRAINT fkb3toat7ors5scfmd3n69dhmr1;
       public          postgres    false    3241    222    218            �           2606    16525 7   topic_create_request_status fkbu4x7l3mn52g6d03dy4wusp9j    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_create_request_status
    ADD CONSTRAINT fkbu4x7l3mn52g6d03dy4wusp9j FOREIGN KEY (request_id) REFERENCES public.topic_create_request(id);
 a   ALTER TABLE ONLY public.topic_create_request_status DROP CONSTRAINT fkbu4x7l3mn52g6d03dy4wusp9j;
       public          postgres    false    3255    226    228            �           2606    16530 )   topic_request fkhvlk8kuydfbafpe4t1ccu0q8p    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT fkhvlk8kuydfbafpe4t1ccu0q8p FOREIGN KEY (topic_id) REFERENCES public.topic(id);
 S   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT fkhvlk8kuydfbafpe4t1ccu0q8p;
       public          postgres    false    231    3253    225            �           2606    16535 '   team_member fkkfpc4pv335asrsvbqokeya87q    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT fkkfpc4pv335asrsvbqokeya87q FOREIGN KEY (member_id) REFERENCES public.app_user(id);
 Q   ALTER TABLE ONLY public.team_member DROP CONSTRAINT fkkfpc4pv335asrsvbqokeya87q;
       public          postgres    false    214    3235    220            �           2606    16540     team fknj76akoopfln51y0fn69daaji    FK CONSTRAINT     �   ALTER TABLE ONLY public.team
    ADD CONSTRAINT fknj76akoopfln51y0fn69daaji FOREIGN KEY (topic_id) REFERENCES public.topic(id);
 J   ALTER TABLE ONLY public.team DROP CONSTRAINT fknj76akoopfln51y0fn69daaji;
       public          postgres    false    3253    218    225            �           2606    16545 !   topic fknmpj5b0q24dc9lpyhhdornf7f    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic
    ADD CONSTRAINT fknmpj5b0q24dc9lpyhhdornf7f FOREIGN KEY (adding_request_id) REFERENCES public.topic_create_request(id);
 K   ALTER TABLE ONLY public.topic DROP CONSTRAINT fknmpj5b0q24dc9lpyhhdornf7f;
       public          postgres    false    226    225    3255            �           2606    16550 $   app_user fkowgby7vq413ddm7xf8hce8n8n    FK CONSTRAINT     �   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT fkowgby7vq413ddm7xf8hce8n8n FOREIGN KEY (study_group_id) REFERENCES public.study_group(id);
 N   ALTER TABLE ONLY public.app_user DROP CONSTRAINT fkowgby7vq413ddm7xf8hce8n8n;
       public          postgres    false    214    216    3239            �           2606    16555 (   team_request fkoxnvwh7u5b7riti1tim84fkva    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT fkoxnvwh7u5b7riti1tim84fkva FOREIGN KEY (requesting_user_id) REFERENCES public.app_user(id);
 R   ALTER TABLE ONLY public.team_request DROP CONSTRAINT fkoxnvwh7u5b7riti1tim84fkva;
       public          postgres    false    214    223    3235            �           2606    16560 (   team_request fktctko3jheeky34b3lj7kmmwij    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT fktctko3jheeky34b3lj7kmmwij FOREIGN KEY (team_id) REFERENCES public.team(id);
 R   ALTER TABLE ONLY public.team_request DROP CONSTRAINT fktctko3jheeky34b3lj7kmmwij;
       public          postgres    false    218    3241    223            b   �  x�M�˲�X@���S��ա-*� �X���\�!O��<���g���R]��tR7߀��VB�����b��M�d����C�
��<P�i�#�sǊ���̴����,���Vԉ0R����(�2v _QQ�=@��'�+ި���1]��,�4��$A���U�\�]��_����{�rw��"�s�6.G����<�d14y�jb&�ΐ%=�і|u�g� ���g���q}��o�?���G@����������V��`�ʢ�1�����y뿻J��Y��괥�jl�����(?CX�k9K�CӉbgx�i�|fU�?U�ޘ�~}i���-@uh�1�q+�=��A�ۮ�t!p��u"D�?
�cH�����Oж�%��ĈE 4F�`�s�A�'_\`ug�b����q��u G�����/�u�_Ū����G'�+�l04h��²�
�3�+`Q�Ow�^���&��Mz4�IZ.M3���rC�~����,91�_�O"�8	�&�:��趁����"`��N��B2���r<�Jt~Ԧk1�
K)0�|)��^%��'� ���fn��� ��״�ν��<�Hbo>������Q��D4�Ê+�W�c{����eF�=M���{�0n�ۓf��5���I"/6��Q��� �����V�|6�Rw�D����p~b��r���B�=�rK7�y�_>^���4O�ʌ���]Z��2�ꘊ���4��섋��l���t��ka5      d   [   x�E���0��s�E#���8�z�f�1�`K{!��I_���)1P#�y�^���uʼK��J�B#�5s�'�&�v~a�����C�      f   6   x�34�0�b���v_����24	4\�wa����.l �w\������� ��      h   a   x�]���@C�5T�a�|B-鿎7O�"��<�:�y��Q�iI���>+����|�7��{!-8d?����F� w���v����T�kc�      j   #   x�34�46�2��`҈�А��LZp��qqq \I�      k      x������ � �      m   �  x��T�J�@>o�b��ֆ��Tͳ��̓O�EQ0�ت!�F��`�ֿj}�o��o��	zl&��~3��Nv�62.r�rT)����$�����тA}��+x��o���Zm���	�p��D��j,cAנ�#{�g���~]�M�@��Ȑ�W_7n�Tk�3���؆U[58D��L��/x��'뾐�C��;���c�������ahV�>�Yv�d\���j�\Ga�.P�Md�s���$�?x�.jPn8U'ufJ�nA=��pF�saTQ��{UZR�9�s\!d4�I�昳ь�"�f��/+�-�'�oF�V��[8%a��M��Y�yC� ]����&�sA�b�MJ�Z&�cJ�A�üt4�UvF�j�٬�9���h�w����@�^��n�-�ɍ�gl2�M�Q�#����0�O�5b      n   �  x��U�n�@>;O1pjI�����ǈ�	8  M�BE�Z姥i��(��
�Ѐ�
�o�7&-$ʁ���Z�of�ٙ�L�c\�W]�jj���b?P&
��S�'����@�5�E��9�5��;�Ewʙ}�$���>WJ9܃�Q,m�6a�y����ɡ?�-�x%�^="�z5���(.�9G�3�����o�+8[֢�Q]����_�`n��>�������;���OG�_�u�"������ڞ���8:*��Hc����)c���W���΅@�i}�sI�1�y5�HϮc =�m��&��!�?	�V��	U=�䤹L��#CUp�SK�1I� `�gᚋz�"͓��ۏ�=y�*��&ؠR2gJ��aA�I�ܙz�?΍�H��s�PN7)j���E�Zdh�[��oagR��2��"���L����I��*t]�5-�)�w�8�#�$��1��@�X��*J�+��T�������N�J˼O�U�ʷ:�.�<�.q�K���:��>"�L��`��$��i�T�%t�߀0E�=�'\G�� t	ܻ���hA��$�8�5�3�t��x�S�d%�NEn�b�M&vӶ�i����۰붍��H����EHyHR��*�J? >��      p   #  x�]QKN1];��&��|6܀��ر�e,P� $$P7C�0�
΍���ʰ�e;�;��#�q�{>�u��R~K���������ƶ�|�PB6�{  �ay�L1]�P� �M�,(�,�g�4ɐ�i�y�/��w�m$������;I$M��T0���Hd�?q�_��z]Wu�]�����CMX��A��B�w��p�e�#�%����2�����_60ZO�T8��z-�A���]��̯@h�&,���D����-Κ,���"��bm	h�k�/�ja�R?�~�N      s      x������ � �      u      x������ � �     