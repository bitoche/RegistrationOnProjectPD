PGDMP         $                |            registrationonprojectdb    15.2    15.2 c    |           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            }           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ~           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    35923    registrationonprojectdb    DATABASE     �   CREATE DATABASE registrationonprojectdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
 '   DROP DATABASE registrationonprojectdb;
                postgres    false            �            1259    36565    app_user    TABLE     0  CREATE TABLE public.app_user (
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
       public         heap    postgres    false            �            1259    36564    app_user_id_seq    SEQUENCE     x   CREATE SEQUENCE public.app_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.app_user_id_seq;
       public          postgres    false    215            �           0    0    app_user_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.app_user_id_seq OWNED BY public.app_user.id;
          public          postgres    false    214            �            1259    36735    study_group    TABLE     r   CREATE TABLE public.study_group (
    id integer NOT NULL,
    name character varying(255),
    course integer
);
    DROP TABLE public.study_group;
       public         heap    postgres    false            �            1259    36734    study_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.study_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.study_group_id_seq;
       public          postgres    false    234            �           0    0    study_group_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.study_group_id_seq OWNED BY public.study_group.id;
          public          postgres    false    233            �            1259    36576    team    TABLE     k   CREATE TABLE public.team (
    id bigint NOT NULL,
    name character varying(255),
    topic_id bigint
);
    DROP TABLE public.team;
       public         heap    postgres    false            �            1259    36575    team_id_seq    SEQUENCE     t   CREATE SEQUENCE public.team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.team_id_seq;
       public          postgres    false    217            �           0    0    team_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.team_id_seq OWNED BY public.team.id;
          public          postgres    false    216            �            1259    36586    team_member    TABLE     �   CREATE TABLE public.team_member (
    id bigint NOT NULL,
    date timestamp(6) without time zone,
    role smallint,
    member_id bigint,
    CONSTRAINT team_member_role_check CHECK (((role >= 0) AND (role <= 2)))
);
    DROP TABLE public.team_member;
       public         heap    postgres    false            �            1259    36585    team_member_id_seq    SEQUENCE     {   CREATE SEQUENCE public.team_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.team_member_id_seq;
       public          postgres    false    220            �           0    0    team_member_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.team_member_id_seq OWNED BY public.team_member.id;
          public          postgres    false    219            �            1259    36582    team_members    TABLE     b   CREATE TABLE public.team_members (
    team_id bigint NOT NULL,
    members_id bigint NOT NULL
);
     DROP TABLE public.team_members;
       public         heap    postgres    false            �            1259    36594    team_request    TABLE     �   CREATE TABLE public.team_request (
    id bigint NOT NULL,
    date timestamp(6) without time zone,
    requesting_user_id bigint,
    team_id bigint
);
     DROP TABLE public.team_request;
       public         heap    postgres    false            �            1259    36593    team_request_id_seq    SEQUENCE     |   CREATE SEQUENCE public.team_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.team_request_id_seq;
       public          postgres    false    222            �           0    0    team_request_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.team_request_id_seq OWNED BY public.team_request.id;
          public          postgres    false    221            �            1259    36601    topic    TABLE     �   CREATE TABLE public.topic (
    id bigint NOT NULL,
    adding_date timestamp(6) without time zone,
    description character varying(2048),
    name character varying(255),
    approved_user_id bigint,
    adding_request_id bigint
);
    DROP TABLE public.topic;
       public         heap    postgres    false            �            1259    36610    topic_create_request    TABLE     �   CREATE TABLE public.topic_create_request (
    id bigint NOT NULL,
    request_date timestamp(6) without time zone,
    topic_description character varying(2048),
    topic_name character varying(255),
    requesting_user_id bigint
);
 (   DROP TABLE public.topic_create_request;
       public         heap    postgres    false            �            1259    36609    topic_create_request_id_seq    SEQUENCE     �   CREATE SEQUENCE public.topic_create_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.topic_create_request_id_seq;
       public          postgres    false    226            �           0    0    topic_create_request_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.topic_create_request_id_seq OWNED BY public.topic_create_request.id;
          public          postgres    false    225            �            1259    36619    topic_create_request_status    TABLE     (  CREATE TABLE public.topic_create_request_status (
    id bigint NOT NULL,
    comment character varying(255),
    date timestamp(6) without time zone,
    status smallint,
    request_id bigint,
    CONSTRAINT topic_create_request_status_status_check CHECK (((status >= 0) AND (status <= 3)))
);
 /   DROP TABLE public.topic_create_request_status;
       public         heap    postgres    false            �            1259    36618 "   topic_create_request_status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.topic_create_request_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.topic_create_request_status_id_seq;
       public          postgres    false    228            �           0    0 "   topic_create_request_status_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.topic_create_request_status_id_seq OWNED BY public.topic_create_request_status.id;
          public          postgres    false    227            �            1259    36600    topic_id_seq    SEQUENCE     u   CREATE SEQUENCE public.topic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.topic_id_seq;
       public          postgres    false    224            �           0    0    topic_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.topic_id_seq OWNED BY public.topic.id;
          public          postgres    false    223            �            1259    36627    topic_request    TABLE     r   CREATE TABLE public.topic_request (
    id bigint NOT NULL,
    requesting_team_id bigint,
    topic_id bigint
);
 !   DROP TABLE public.topic_request;
       public         heap    postgres    false            �            1259    36626    topic_request_id_seq    SEQUENCE     }   CREATE SEQUENCE public.topic_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.topic_request_id_seq;
       public          postgres    false    230            �           0    0    topic_request_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.topic_request_id_seq OWNED BY public.topic_request.id;
          public          postgres    false    229            �            1259    36634    topic_request_status    TABLE     (  CREATE TABLE public.topic_request_status (
    id bigint NOT NULL,
    comment character varying(255),
    status smallint,
    status_date timestamp(6) without time zone,
    reviewed_admin_id bigint,
    CONSTRAINT topic_request_status_status_check CHECK (((status >= 0) AND (status <= 3)))
);
 (   DROP TABLE public.topic_request_status;
       public         heap    postgres    false            �            1259    36633    topic_request_status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.topic_request_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.topic_request_status_id_seq;
       public          postgres    false    232            �           0    0    topic_request_status_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.topic_request_status_id_seq OWNED BY public.topic_request_status.id;
          public          postgres    false    231            �           2604    36568    app_user id    DEFAULT     j   ALTER TABLE ONLY public.app_user ALTER COLUMN id SET DEFAULT nextval('public.app_user_id_seq'::regclass);
 :   ALTER TABLE public.app_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    36738    study_group id    DEFAULT     p   ALTER TABLE ONLY public.study_group ALTER COLUMN id SET DEFAULT nextval('public.study_group_id_seq'::regclass);
 =   ALTER TABLE public.study_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    36579    team id    DEFAULT     b   ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.team_id_seq'::regclass);
 6   ALTER TABLE public.team ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    36589    team_member id    DEFAULT     p   ALTER TABLE ONLY public.team_member ALTER COLUMN id SET DEFAULT nextval('public.team_member_id_seq'::regclass);
 =   ALTER TABLE public.team_member ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    36597    team_request id    DEFAULT     r   ALTER TABLE ONLY public.team_request ALTER COLUMN id SET DEFAULT nextval('public.team_request_id_seq'::regclass);
 >   ALTER TABLE public.team_request ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    36604    topic id    DEFAULT     d   ALTER TABLE ONLY public.topic ALTER COLUMN id SET DEFAULT nextval('public.topic_id_seq'::regclass);
 7   ALTER TABLE public.topic ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    36613    topic_create_request id    DEFAULT     �   ALTER TABLE ONLY public.topic_create_request ALTER COLUMN id SET DEFAULT nextval('public.topic_create_request_id_seq'::regclass);
 F   ALTER TABLE public.topic_create_request ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    36622    topic_create_request_status id    DEFAULT     �   ALTER TABLE ONLY public.topic_create_request_status ALTER COLUMN id SET DEFAULT nextval('public.topic_create_request_status_id_seq'::regclass);
 M   ALTER TABLE public.topic_create_request_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    36630    topic_request id    DEFAULT     t   ALTER TABLE ONLY public.topic_request ALTER COLUMN id SET DEFAULT nextval('public.topic_request_id_seq'::regclass);
 ?   ALTER TABLE public.topic_request ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    36637    topic_request_status id    DEFAULT     �   ALTER TABLE ONLY public.topic_request_status ALTER COLUMN id SET DEFAULT nextval('public.topic_request_status_id_seq'::regclass);
 F   ALTER TABLE public.topic_request_status ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    232    232            f          0    36565    app_user 
   TABLE DATA           t   COPY public.app_user (id, birth_date, login, name, password, patronymic, role, surname, study_group_id) FROM stdin;
    public          postgres    false    215   �y       y          0    36735    study_group 
   TABLE DATA           7   COPY public.study_group (id, name, course) FROM stdin;
    public          postgres    false    234   �|       h          0    36576    team 
   TABLE DATA           2   COPY public.team (id, name, topic_id) FROM stdin;
    public          postgres    false    217   %}       k          0    36586    team_member 
   TABLE DATA           @   COPY public.team_member (id, date, role, member_id) FROM stdin;
    public          postgres    false    220   �}       i          0    36582    team_members 
   TABLE DATA           ;   COPY public.team_members (team_id, members_id) FROM stdin;
    public          postgres    false    218   ~       m          0    36594    team_request 
   TABLE DATA           M   COPY public.team_request (id, date, requesting_user_id, team_id) FROM stdin;
    public          postgres    false    222   R~       o          0    36601    topic 
   TABLE DATA           h   COPY public.topic (id, adding_date, description, name, approved_user_id, adding_request_id) FROM stdin;
    public          postgres    false    224   �~       q          0    36610    topic_create_request 
   TABLE DATA           s   COPY public.topic_create_request (id, request_date, topic_description, topic_name, requesting_user_id) FROM stdin;
    public          postgres    false    226   q       s          0    36619    topic_create_request_status 
   TABLE DATA           \   COPY public.topic_create_request_status (id, comment, date, status, request_id) FROM stdin;
    public          postgres    false    228   ��       u          0    36627    topic_request 
   TABLE DATA           I   COPY public.topic_request (id, requesting_team_id, topic_id) FROM stdin;
    public          postgres    false    230   _�       w          0    36634    topic_request_status 
   TABLE DATA           c   COPY public.topic_request_status (id, comment, status, status_date, reviewed_admin_id) FROM stdin;
    public          postgres    false    232   |�       �           0    0    app_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.app_user_id_seq', 24, true);
          public          postgres    false    214            �           0    0    study_group_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.study_group_id_seq', 12, true);
          public          postgres    false    233            �           0    0    team_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.team_id_seq', 7, true);
          public          postgres    false    216            �           0    0    team_member_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.team_member_id_seq', 8, true);
          public          postgres    false    219            �           0    0    team_request_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.team_request_id_seq', 2, true);
          public          postgres    false    221            �           0    0    topic_create_request_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.topic_create_request_id_seq', 9, true);
          public          postgres    false    225            �           0    0 "   topic_create_request_status_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.topic_create_request_status_id_seq', 7, true);
          public          postgres    false    227            �           0    0    topic_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.topic_id_seq', 12, true);
          public          postgres    false    223            �           0    0    topic_request_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.topic_request_id_seq', 1, false);
          public          postgres    false    229            �           0    0    topic_request_status_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.topic_request_status_id_seq', 1, false);
          public          postgres    false    231            �           2606    36574    app_user app_user_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.app_user DROP CONSTRAINT app_user_pkey;
       public            postgres    false    215            �           2606    36726    app_user login 
   CONSTRAINT     J   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT login UNIQUE (login);
 8   ALTER TABLE ONLY public.app_user DROP CONSTRAINT login;
       public            postgres    false    215            �           2606    36740    study_group study_group_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.study_group
    ADD CONSTRAINT study_group_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.study_group DROP CONSTRAINT study_group_pkey;
       public            postgres    false    234            �           2606    36592    team_member team_member_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT team_member_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.team_member DROP CONSTRAINT team_member_pkey;
       public            postgres    false    220            �           2606    36581    team team_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.team DROP CONSTRAINT team_pkey;
       public            postgres    false    217            �           2606    36599    team_request team_request_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT team_request_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.team_request DROP CONSTRAINT team_request_pkey;
       public            postgres    false    222            �           2606    36617 .   topic_create_request topic_create_request_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.topic_create_request
    ADD CONSTRAINT topic_create_request_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.topic_create_request DROP CONSTRAINT topic_create_request_pkey;
       public            postgres    false    226            �           2606    36625 <   topic_create_request_status topic_create_request_status_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.topic_create_request_status
    ADD CONSTRAINT topic_create_request_status_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.topic_create_request_status DROP CONSTRAINT topic_create_request_status_pkey;
       public            postgres    false    228            �           2606    36608    topic topic_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.topic
    ADD CONSTRAINT topic_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.topic DROP CONSTRAINT topic_pkey;
       public            postgres    false    224            �           2606    36632     topic_request topic_request_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT topic_request_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT topic_request_pkey;
       public            postgres    false    230            �           2606    36640 .   topic_request_status topic_request_status_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.topic_request_status
    ADD CONSTRAINT topic_request_status_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.topic_request_status DROP CONSTRAINT topic_request_status_pkey;
       public            postgres    false    232            �           2606    36648 )   team_request uk_14e3vm3mavy26x0wochcwc9oy 
   CONSTRAINT     g   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT uk_14e3vm3mavy26x0wochcwc9oy UNIQUE (team_id);
 S   ALTER TABLE ONLY public.team_request DROP CONSTRAINT uk_14e3vm3mavy26x0wochcwc9oy;
       public            postgres    false    222            �           2606    36644 )   team_members uk_4adet9n1mfa8wy3wbe963bt36 
   CONSTRAINT     j   ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT uk_4adet9n1mfa8wy3wbe963bt36 UNIQUE (members_id);
 S   ALTER TABLE ONLY public.team_members DROP CONSTRAINT uk_4adet9n1mfa8wy3wbe963bt36;
       public            postgres    false    218            �           2606    36656 *   topic_request uk_7c65d231oewycbqir69ja9m13 
   CONSTRAINT     i   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT uk_7c65d231oewycbqir69ja9m13 UNIQUE (topic_id);
 T   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT uk_7c65d231oewycbqir69ja9m13;
       public            postgres    false    230            �           2606    36646 )   team_request uk_ae25bnla80wldqco3wp3v9dvu 
   CONSTRAINT     r   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT uk_ae25bnla80wldqco3wp3v9dvu UNIQUE (requesting_user_id);
 S   ALTER TABLE ONLY public.team_request DROP CONSTRAINT uk_ae25bnla80wldqco3wp3v9dvu;
       public            postgres    false    222            �           2606    36652 8   topic_create_request_status uk_bl9mud127j6g44un3madsavv9 
   CONSTRAINT     y   ALTER TABLE ONLY public.topic_create_request_status
    ADD CONSTRAINT uk_bl9mud127j6g44un3madsavv9 UNIQUE (request_id);
 b   ALTER TABLE ONLY public.topic_create_request_status DROP CONSTRAINT uk_bl9mud127j6g44un3madsavv9;
       public            postgres    false    228            �           2606    36642 !   team uk_d8dslqiatvrcpegql28mgo0q6 
   CONSTRAINT     `   ALTER TABLE ONLY public.team
    ADD CONSTRAINT uk_d8dslqiatvrcpegql28mgo0q6 UNIQUE (topic_id);
 K   ALTER TABLE ONLY public.team DROP CONSTRAINT uk_d8dslqiatvrcpegql28mgo0q6;
       public            postgres    false    217            �           2606    36654 *   topic_request uk_gv03u9vs2v384fc46k91jsh63 
   CONSTRAINT     s   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT uk_gv03u9vs2v384fc46k91jsh63 UNIQUE (requesting_team_id);
 T   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT uk_gv03u9vs2v384fc46k91jsh63;
       public            postgres    false    230            �           2606    36658 1   topic_request_status uk_tng3qxm4v92g4mhy0vbg6jmki 
   CONSTRAINT     y   ALTER TABLE ONLY public.topic_request_status
    ADD CONSTRAINT uk_tng3qxm4v92g4mhy0vbg6jmki UNIQUE (reviewed_admin_id);
 [   ALTER TABLE ONLY public.topic_request_status DROP CONSTRAINT uk_tng3qxm4v92g4mhy0vbg6jmki;
       public            postgres    false    232            �           2606    36699 0   topic_create_request fk2609bn7qglsbjl329ygebe9lu    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_create_request
    ADD CONSTRAINT fk2609bn7qglsbjl329ygebe9lu FOREIGN KEY (requesting_user_id) REFERENCES public.app_user(id);
 Z   ALTER TABLE ONLY public.topic_create_request DROP CONSTRAINT fk2609bn7qglsbjl329ygebe9lu;
       public          postgres    false    215    226    3236            �           2606    36664 (   team_members fk3d90dqttrv7mdpfxgdml4oljk    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT fk3d90dqttrv7mdpfxgdml4oljk FOREIGN KEY (members_id) REFERENCES public.team_member(id);
 R   ALTER TABLE ONLY public.team_members DROP CONSTRAINT fk3d90dqttrv7mdpfxgdml4oljk;
       public          postgres    false    218    3246    220            �           2606    36689 !   topic fk3q5a0qqdl2xagfb4cb2ykjlp2    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic
    ADD CONSTRAINT fk3q5a0qqdl2xagfb4cb2ykjlp2 FOREIGN KEY (approved_user_id) REFERENCES public.app_user(id);
 K   ALTER TABLE ONLY public.topic DROP CONSTRAINT fk3q5a0qqdl2xagfb4cb2ykjlp2;
       public          postgres    false    215    224    3236            �           2606    36709 )   topic_request fk8tdm7c5mdv5ckm73ynhpg8vv3    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT fk8tdm7c5mdv5ckm73ynhpg8vv3 FOREIGN KEY (requesting_team_id) REFERENCES public.team(id);
 S   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT fk8tdm7c5mdv5ckm73ynhpg8vv3;
       public          postgres    false    230    3240    217            �           2606    36719 0   topic_request_status fkafg54dvkcbjqvqpn8dxmexpvq    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_request_status
    ADD CONSTRAINT fkafg54dvkcbjqvqpn8dxmexpvq FOREIGN KEY (reviewed_admin_id) REFERENCES public.app_user(id);
 Z   ALTER TABLE ONLY public.topic_request_status DROP CONSTRAINT fkafg54dvkcbjqvqpn8dxmexpvq;
       public          postgres    false    215    232    3236            �           2606    36669 (   team_members fkb3toat7ors5scfmd3n69dhmr1    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT fkb3toat7ors5scfmd3n69dhmr1 FOREIGN KEY (team_id) REFERENCES public.team(id);
 R   ALTER TABLE ONLY public.team_members DROP CONSTRAINT fkb3toat7ors5scfmd3n69dhmr1;
       public          postgres    false    217    3240    218            �           2606    36704 7   topic_create_request_status fkbu4x7l3mn52g6d03dy4wusp9j    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_create_request_status
    ADD CONSTRAINT fkbu4x7l3mn52g6d03dy4wusp9j FOREIGN KEY (request_id) REFERENCES public.topic_create_request(id);
 a   ALTER TABLE ONLY public.topic_create_request_status DROP CONSTRAINT fkbu4x7l3mn52g6d03dy4wusp9j;
       public          postgres    false    226    228    3256            �           2606    36714 )   topic_request fkhvlk8kuydfbafpe4t1ccu0q8p    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic_request
    ADD CONSTRAINT fkhvlk8kuydfbafpe4t1ccu0q8p FOREIGN KEY (topic_id) REFERENCES public.topic(id);
 S   ALTER TABLE ONLY public.topic_request DROP CONSTRAINT fkhvlk8kuydfbafpe4t1ccu0q8p;
       public          postgres    false    230    3254    224            �           2606    36674 '   team_member fkkfpc4pv335asrsvbqokeya87q    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_member
    ADD CONSTRAINT fkkfpc4pv335asrsvbqokeya87q FOREIGN KEY (member_id) REFERENCES public.app_user(id);
 Q   ALTER TABLE ONLY public.team_member DROP CONSTRAINT fkkfpc4pv335asrsvbqokeya87q;
       public          postgres    false    215    3236    220            �           2606    36659     team fknj76akoopfln51y0fn69daaji    FK CONSTRAINT     �   ALTER TABLE ONLY public.team
    ADD CONSTRAINT fknj76akoopfln51y0fn69daaji FOREIGN KEY (topic_id) REFERENCES public.topic(id);
 J   ALTER TABLE ONLY public.team DROP CONSTRAINT fknj76akoopfln51y0fn69daaji;
       public          postgres    false    3254    224    217            �           2606    36694 !   topic fknmpj5b0q24dc9lpyhhdornf7f    FK CONSTRAINT     �   ALTER TABLE ONLY public.topic
    ADD CONSTRAINT fknmpj5b0q24dc9lpyhhdornf7f FOREIGN KEY (adding_request_id) REFERENCES public.topic_create_request(id);
 K   ALTER TABLE ONLY public.topic DROP CONSTRAINT fknmpj5b0q24dc9lpyhhdornf7f;
       public          postgres    false    3256    224    226            �           2606    36741 $   app_user fkowgby7vq413ddm7xf8hce8n8n    FK CONSTRAINT     �   ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT fkowgby7vq413ddm7xf8hce8n8n FOREIGN KEY (study_group_id) REFERENCES public.study_group(id);
 N   ALTER TABLE ONLY public.app_user DROP CONSTRAINT fkowgby7vq413ddm7xf8hce8n8n;
       public          postgres    false    215    234    3272            �           2606    36679 (   team_request fkoxnvwh7u5b7riti1tim84fkva    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT fkoxnvwh7u5b7riti1tim84fkva FOREIGN KEY (requesting_user_id) REFERENCES public.app_user(id);
 R   ALTER TABLE ONLY public.team_request DROP CONSTRAINT fkoxnvwh7u5b7riti1tim84fkva;
       public          postgres    false    215    222    3236            �           2606    36684 (   team_request fktctko3jheeky34b3lj7kmmwij    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_request
    ADD CONSTRAINT fktctko3jheeky34b3lj7kmmwij FOREIGN KEY (team_id) REFERENCES public.team(id);
 R   ALTER TABLE ONLY public.team_request DROP CONSTRAINT fktctko3jheeky34b3lj7kmmwij;
       public          postgres    false    217    3240    222            f   �  x�M�˲�J���s�l���#*� �X������U�(�A��:��Af�S'U9I�<�ѡ�Z	�z5tw}��_M�&I�KR]��!����v(���ّ�c���|f���Ԍx��~���L+�D�kwZ��FL;�������@ݓS�o����.�wI�Q�Un����\��_��������^��5LM��9w��x��v�O���F51�egȒ���hK���3�H��S���V���k������# A�����C��?�r+�5��v(��Ā�������w)�Jg�bD��Ӗ����s3+��a���,=M'���9���Uy�������[Зf�g�/�C��"�A���!Ѓ�$���L�[['B4��0�1�d�쿎�m�XR��A�XT@cD�w4��i��F<�����Q@�y��i\��A��K+UF\S�ݖ5ҕ�Ų..�k���	�� �r�՝=J�Y2�Ǖ�3ԁ�Bh��/��׵~��Csm������Р�'-,K��@�
X8����'e�	xd��x���KDӌqx����wy:KN�A�쓈�N�(�I+�T�t���vܻ��@��|!��UT���%:?jӵ�k��[��l�M֓Z �fl6s�JT���5��й��'I��G��Vѹ8��՜��bXq%��J�cl��s����)�x��������mK���np�$�y�(��\Y~lj�O�I>wR��U�y���i8?1�y��F������a6      y   [   x�E���0��s�E#���8�z�f�1�`K{!��I_���)1P#�y�^���uʼK��J�B#�5s�'�&�v~a�����C�      h   s   x�3⼰�[.6_�va���[.쿰���;8c���9/L���bÅ��	�Y@�=@-{/l��A!8$l�ya�����pH�(ra��fۜ�bP��b���l� �'@:      k   e   x�e���PD��s4�����B�uD�Xi��PQ_�W��5[�-u�P#s$�pq<ض�`�8�7�F�;#���ǵZ�q��GQ����<�靉�~K!      i   %   x�3�4�2�4�2�4�2�4�2�4�2������� 6��      m   <   x�M���0D�3Ta�-�h"���:�:�IC̡9ؗ�Yq+-�������z���O����~      o   �   x��T��@�}S�9����YRCG��!����	�@ DVx�N����k�����l�Y6\�9�,g.4�M	�x�Ը�����U�����`�˱�ǳ�0%�,'{E�7��k�~+�Q���G�N�/��(T̃?�fe��c�	�Ho�^��xH[��A�ŧ��7�~VI�N�O�k��{c-��"���(��8tO      q     x��MN�0���)|�Z�ĉ�%�c�	h	�JH,� '�Z���
�7b,Q~�,�ٌތ�go�����fF�L�S�M��Y�+����P��x��p)�c��-^���5�p��O2��9\(�n����P�S^9�~)�R+�g���.Ԃ��ޑ�>w*�
�&:�+��C_�T�?��m0��X%ǳ�j*��
�|2�p�)S�#�����<�����֓U�u7׃�����|����%n`eJ�s��(9�))B������4SD��׸C#�|WT�$I^M7�      s   �   x�m�1
AE��{��lf��Cx� �Yjm!�le�
�FFm����'����`'�<�E���8��j;C����k�+�Kh����a<���˒�&B�-�F�/A�3D_B��G��$��A��W��#A[vAQ�6���ߥ��wZ9o������	m�Ԭ5j���G��#V�      u      x������ � �      w      x������ � �     