Content-Type: multipart/mixed; boundary="===============1372634225971497494=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 17/17] p2p: Build P2P and WFD IEs for group's management
 frames
Date: Thu, 10 Sep 2020 01:33:13 +0200
Message-ID: <CAOq732KANR0Z9fGE3q+3++0dtVsvf7nGN_rP7v9OzgxWDfcLeQ@mail.gmail.com>
In-Reply-To: <24617eca-7006-09a0-85d7-2d0f398705a9@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1372634225971497494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 9 Sep 2020 at 22:35, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/8/20 6:49 PM, Andrew Zaborowski wrote:
> > +static size_t p2p_group_get_ies_len(enum mpdu_management_subtype type,
> > +                                     void *user_data)
> > +{
> > +     switch (type) {
> > +     case MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE:
> > +     case MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE:
> > +     case MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE:
> > +     case MPDU_MANAGEMENT_SUBTYPE_BEACON:
> > +             return 256;
>
> This seems rather brittle
>
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static size_t p2p_group_write_ies(enum mpdu_management_subtype type,
> > +                                     uint8_t *out_buf, void *user_data)
> > +{
> > +     struct p2p_device *dev =3D user_data;
> > +     uint8_t *ptr =3D out_buf;
> > +     L_AUTO_FREE_VAR(uint8_t *, p2p_ie) =3D NULL;
> > +     size_t p2p_ie_len;
> > +     struct p2p_wfd_properties *wfd =3D NULL;
> > +     const struct p2p_peer *wfd_client =3D NULL;
> > +
> > +     switch (type) {
> > +     case MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE:
> > +     case MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE:
> > +     {
> > +             /*
> > +              * Wi-Fi P2P Technical Specification v1.7 Section 4.2.5:
> > +              * "If neither P2P attribute is required according to the
> > +              * conditions in Table 55, then a P2P IE containing no P2P
> > +              * attributes is included."
> > +              * This is going to be our case.
> > +              */
> > +             struct p2p_association_resp info =3D {};
> > +
> > +             p2p_ie =3D p2p_build_association_resp(&info, &p2p_ie_len);
> > +
> > +             if (dev->conn_own_wfd && !dev->conn_own_wfd->r2)
> > +                     wfd =3D dev->conn_own_wfd;
> > +
> > +             break;
> > +     }
> > +
> > +     case MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE:
> > +     {
> > +             /*
> > +              * 3.2.2: "A P2P Group Owner shall not include a P2P IE
> > +              * in the Probe Response frame if the received Probe Requ=
est
> > +              * frame does not contain a P2P IE."
> > +              * For simplicity include it always, same applies to the
> > +              * WFD IE too.
>
> ???

I was thinking of adding the contents of the request frame as another
parameter to ops.write_mgmt_frame_ies() and
ops.get_mgmt_frame_ies_len() but it seemed to be an overkill.
Shouldn't the receiving device just discard the IEs it doesn't care
about?

>
> > +              */
> > +             struct p2p_probe_resp info =3D {};
> > +
> > +             info.capability =3D dev->capability;
> > +             info.device_info =3D dev->device_info;
> > +
> > +             if (dev->conn_peer_added) {
> > +                     struct p2p_client_info_descriptor client =3D {};
> > +
> > +                     memcpy(client.device_addr,
> > +                             dev->conn_client_dev_info.device_addr, 6);
> > +                     memcpy(client.interface_addr,
> > +                             dev->conn_peer_interface_addr, 6);
> > +                     client.device_caps =3D
> > +                             dev->conn_client_capability.device_caps;
> > +                     client.wsc_config_methods =3D
> > +                             dev->conn_client_dev_info.wsc_config_meth=
ods;
> > +                     client.primary_device_type =3D
> > +                             dev->conn_client_dev_info.primary_device_=
type;
> > +                     l_strlcpy(client.device_name,
> > +                                     dev->conn_client_dev_info.device_=
name,
> > +                                     sizeof(client.device_name));
> > +
> > +                     info.group_clients =3D l_queue_new();
> > +                     l_queue_push_tail(info.group_clients,
> > +                                     l_memdup(&client, sizeof(client))=
);
> > +             }
> > +
> > +             p2p_ie =3D p2p_build_probe_resp(&info, &p2p_ie_len);
> > +             p2p_clear_probe_resp(&info);
> > +
> > +             if (dev->conn_own_wfd)
> > +                     wfd_client =3D dev->conn_peer;
> > +
> > +             wfd =3D p2p_own_wfd;
> > +             break;
> > +     }
> > +
> > +     case MPDU_MANAGEMENT_SUBTYPE_BEACON:
> > +     {
> > +             struct p2p_beacon info =3D {};
> > +
> > +             info.capability =3D dev->capability;
> > +             memcpy(info.device_addr, dev->addr, 6);
> > +             p2p_ie =3D p2p_build_beacon(&info, &p2p_ie_len);
> > +
> > +             wfd =3D p2p_own_wfd;
> > +             break;
> > +     }
> > +
> > +     default:
> > +             return 0;
> > +     }
> > +
> > +     memcpy(ptr, p2p_ie, p2p_ie_len);
> > +     ptr +=3D p2p_ie_len;
>
> So are you leaking p2p_ie here?

It is defined with L_AUTO_FREE_VAR.

>
> And also, p2p_build utilities use a dynamically-growing buffer to build a=
ll the
> attributes and ie_tlv_encapsulate_p2p_payload can produce a ton of IEs, n=
ot just
> a single one.  So I think you need something a bit smarter than
> get_mgmt_frame_ies_len() method.

But we know how much data we put into those frames and there's no way
we can produce more than one P2P IE probably unless we start
implementing "P2P Services" specification.  Even then we can easily
calculate an upper bound on the size of the IE string.

>
> Perhaps ie_tlv_builder should be passed in directly and that entire class=
 be
> made smarter.  Including adding the ability to encapsulate p2p/wsc/vendor=
 TLVs.

We could do that, or we could also return a new uint8_t buffer and its
length from write_mgmt_frame_ies().  Or keep this proposed "zerocopy"
API (more like "less copy"). I'm ok with either option.

Best regards
--===============1372634225971497494==--

