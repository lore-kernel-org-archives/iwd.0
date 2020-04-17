Content-Type: multipart/mixed; boundary="===============0257660729513702766=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 05/17] p2p: Add main device settings
Date: Sat, 18 Apr 2020 01:02:00 +0200
Message-ID: <CAOq732+nQX7oAbPvEe-CedFQN3geH67a9vqPx1Cu=pviFVt_GQ@mail.gmail.com>
In-Reply-To: <082c0731-e2c8-c15d-a3c3-fde507994889@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0257660729513702766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 17 Apr 2020 at 18:26, Denis Kenzior <denkenz@gmail.com> wrote:
> On 4/3/20 11:14 AM, Andrew Zaborowski wrote:
> > Read the country code (for channel operating classes), WSC configuration
>
> hmm, shouldn't we be getting this from the kernel directly and not some
> config file?  What if we're roaming?

Looks like we can use NL80211_CMD_GET_REG when initialising the wiphy
in wiphy.c, in the hope that the regulatory domain has been set
already, and query wiphy.c from p2p.c for the domain.  We would also
have to listen for NL80211_CMD_REG_CHANGEs.

My understanding is that as long as the third byte is 4 the channel
numbers don't change their meanings so we don't have to do anything
else than inserting the alpha 2 code in the frame.

Most P2P devices use 'X', 'X', 4 (XX\x4) as the country code in the
P2P frames where the code is required.

>
> > methods and the Primary Device Type from the config file and expose
> > device name as a property.
> > ---
> >   src/p2p.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 189 insertions(+)
> >
> > diff --git a/src/p2p.c b/src/p2p.c
> > index 49111a98..ab21239d 100644
> > --- a/src/p2p.c
> > +++ b/src/p2p.c
> > @@ -60,7 +60,10 @@ struct p2p_device {
> >       uint8_t addr[6];
> >       struct wiphy *wiphy;
> >       unsigned int connections_left;
> > +     struct p2p_capability_attr capability;
> > +     struct p2p_device_info_attr device_info;
> >
> > +     uint8_t country[3];
> >       struct l_queue *peer_list;
> >   };
> >
> > @@ -276,6 +279,9 @@ struct p2p_device *p2p_device_update_from_genl(stru=
ct l_genl_msg *msg,
> >       const uint64_t *wdev_id =3D NULL;
> >       struct wiphy *wiphy =3D NULL;
> >       struct p2p_device *dev;
> > +     char hostname[HOST_NAME_MAX + 1];
> > +     char *str;
> > +     unsigned int uint_val;
> >
> >       if (!l_genl_attr_init(&attr, msg))
> >               return NULL;
> > @@ -345,8 +351,148 @@ struct p2p_device *p2p_device_update_from_genl(st=
ruct l_genl_msg *msg,
> >       dev->wdev_id =3D *wdev_id;
> >       memcpy(dev->addr, ifaddr, ETH_ALEN);
> >       dev->wiphy =3D wiphy;
> > +     gethostname(hostname, sizeof(hostname));
> >       dev->connections_left =3D 1;
> >
> > +     dev->country[0] =3D 'X';
> > +     dev->country[1] =3D 'X';
> > +     dev->country[2] =3D 4;    /* Table E-4 */
> > +
> > +     str =3D l_settings_get_string(iwd_get_config(), "General", "Count=
ryCode");
> > +     if (str) {
> > +             if (strlen(str) !=3D 2)
> > +                     l_error("[General].CountryCode must be a 2-charac=
ter "
> > +                             "string");
> > +             else {
> > +                     dev->country[0] =3D str[0];
> > +                     dev->country[1] =3D str[1];
> > +             }
> > +
> > +             l_free(str);
> > +     }
> > +
> > +     /* TODO: allow masking capability bits through a setting? */
> > +     dev->capability.device_caps =3D P2P_DEVICE_CAP_CONCURRENT_OP;
> > +     dev->capability.group_caps =3D 0;
> > +
> > +     memcpy(dev->device_info.device_addr, dev->addr, 6);
> > +
> > +     dev->device_info.wsc_config_methods =3D
> > +             WSC_CONFIGURATION_METHOD_LABEL |
>
> Do you really need this one?  I think we discussed this at some point,
> and it should be okay, but just checking...

I think we concluded that the current code could support this method.

>
> > +             WSC_CONFIGURATION_METHOD_KEYPAD |
> > +             WSC_CONFIGURATION_METHOD_VIRTUAL_PUSH_BUTTON |
> > +             WSC_CONFIGURATION_METHOD_PHYSICAL_PUSH_BUTTON |
>
> Not sure about this one as a 'default'.

Maybe we should separate 'default' from 'supported', here I set all
the methods that we can support as the default because if we have no
info on the physical capabilities it's difficult to judge what methods
are likely to be available.  On a standard laptop we're likely to have
physical and virtual buttons.

>
> > +             WSC_CONFIGURATION_METHOD_P2P |
> > +             WSC_CONFIGURATION_METHOD_VIRTUAL_DISPLAY_PIN |
> > +             WSC_CONFIGURATION_METHOD_PHYSICAL_DISPLAY_PIN;
> > +     dev->device_info.primary_device_type.category =3D 1;      /* Comp=
uter */
> > +     memcpy(dev->device_info.primary_device_type.oui, microsoft_oui, 3=
);
> > +     dev->device_info.primary_device_type.oui_type =3D 0x04;
> > +     dev->device_info.primary_device_type.subcategory =3D 1;   /* PC */
> > +     l_strlcpy(dev->device_info.device_name, hostname,
> > +                     sizeof(dev->device_info.device_name));
> > +
>
> Okay
>
> > +     /* TODO: possibly interpret a list of strings of config method na=
mes */
> > +     if (l_settings_get_uint(iwd_get_config(), "P2P",
> > +                             "ConfigurationMethodMask", &uint_val)) {
> > +             if (!(dev->device_info.wsc_config_methods & uint_val))
> > +                     l_error("[P2P].ConfigurationMethodMask must conta=
in "
> > +                             "at least one supported method");
> > +             else if (uint_val & ~0xffff)
> > +                     l_error("[P2P].ConfigurationMethodMask should be =
a "
> > +                             "16-bit integer");
> > +             else
> > +                     dev->device_info.wsc_config_methods &=3D uint_val;
> > +     }
> > +
>
> Why a mask?  Why not specify these directly?

We could skip 'Mask' from the name but the idea was that we only
enable the methods that both us and the user can support.

>
> > +     str =3D l_settings_get_string(iwd_get_config(), "P2P", "DeviceCat=
egory");
> > +     if (str) {
> > +             unsigned int i;
> > +             char *endp;
> > +
> > +             i =3D strtoul(str, &endp, 0);
> > +
> > +             if (*endp =3D=3D '\0') {
> > +                     if (i < 1 || i > 255) {
> > +                             l_error("[P2P].DeviceCategory must be in =
the "
> > +                                     "range 1-255");
> > +                             i =3D 0;
> > +                     }
> > +             } else if (!strcmp(str, "Other"))
> > +                     i =3D 255;
> > +             else {
> > +                     for (i =3D 0; i < L_ARRAY_SIZE(device_type_catego=
ries);
> > +                                     i++) {
> > +                             struct device_type_category_info *cat_inf=
o =3D
> > +                                     &device_type_categories[i];
> > +
> > +                             if (!cat_info->category_str)
> > +                                     continue;
> > +
> > +                             if (strcasecmp(str, cat_info->category_st=
r))
> > +                                     continue;
> > +
> > +                             break;
> > +                     }
> > +
> > +                     if (i =3D=3D L_ARRAY_SIZE(device_type_categories)=
) {
> > +                             l_error("Unkown [P2P].DeviceCategory %s",=
 str);
> > +                             i =3D 0;
> > +                     }
> > +             }
> > +
> > +             if (i)
> > +                     dev->device_info.primary_device_type.category =3D=
 i;
> > +     }
> > +
> > +     str =3D l_settings_get_string(iwd_get_config(), "P2P",
> > +                                     "DeviceSubcategory");
> > +     if (str) {
> > +             unsigned int i;
> > +             char *endp;
> > +             unsigned int category =3D
> > +                     dev->device_info.primary_device_type.category;
> > +             struct device_type_category_info *cat_info =3D
> > +                     &device_type_categories[category];
> > +
> > +             i =3D strtoul(str, &endp, 0);
> > +
> > +             if (*endp =3D=3D '\0') {
> > +                     if (i < 1 || i > 255) {
> > +                             l_error("[P2P].DeviceSubcategory must be =
in "
> > +                                     "the range 1-255");
> > +                             i =3D 0;
> > +                     }
> > +             } else if (!strcmp(str, "Other"))
> > +                     i =3D 255;
> > +             else if (category < L_ARRAY_SIZE(device_type_categories) =
&&
> > +                             cat_info->subcategory_max) {
> > +                     for (i =3D 0; i <=3D cat_info->subcategory_max; i=
++) {
> > +                             if (!cat_info->subcategory_str[i])
> > +                                     continue;
> > +
> > +                             if (strcasecmp(str,
> > +                                             cat_info->subcategory_str=
[i]))
> > +                                     continue;
> > +
> > +                             break;
> > +                     }
> > +
> > +                     if (i > cat_info->subcategory_max) {
> > +                             l_error("Unkown [P2P].DeviceSubcategory %=
s",
> > +                                     str);
> > +                             i =3D 0;
> > +                     }
> > +             } else {
> > +                     l_error("Only numeric [P2P].DeviceSubcategory val=
ues "
> > +                             "allowed for this category");
> > +                     i =3D 0;
> > +             }
> > +
> > +             if (i)
> > +                     dev->device_info.primary_device_type.subcategory =
=3D i;
> > +     }
>
> So two things:
>
> Are you sure you want to have the user specify strings instead of the
> oui / type directly?

This supports a numeric or text category and subcategory and the OUI
is hardcoded to microsoft.  I guess we could support specifying the
whole thing as one number too.  I don't see a reason to not support
the string values though.

> What does BlueZ do here for example?

It only supports a hex value and only uses some bits of it.  The DBus
API also only exports and accepts integer values.  We could do this
too, I used strings because it seemed nicer to the users but it does
have the translation problem when used on DBus.

>
> Handling of 'Other' might need to be tweaked depending on how you
> resolve comments to the previous patch.
>
> > +
> >       l_queue_push_tail(p2p_device_list, dev);
> >
> >       l_debug("Created P2P device %" PRIx64, dev->wdev_id);
> > @@ -378,6 +524,46 @@ bool p2p_device_destroy(struct p2p_device *dev)
> >       return true;
> >   }
> >
> > +static bool p2p_device_get_name(struct l_dbus *dbus,
> > +                             struct l_dbus_message *message,
> > +                             struct l_dbus_message_builder *builder,
> > +                             void *user_data)
> > +{
> > +     struct p2p_device *dev =3D user_data;
> > +
> > +     l_dbus_message_builder_append_basic(builder, 's',
> > +                                             dev->device_info.device_n=
ame);
> > +     return true;
> > +}
> > +
> > +static struct l_dbus_message *p2p_device_set_name(struct l_dbus *dbus,
> > +                                     struct l_dbus_message *message,
> > +                                     struct l_dbus_message_iter *new_v=
alue,
> > +                                     l_dbus_property_complete_cb_t com=
plete,
> > +                                     void *user_data)
> > +{
> > +     struct p2p_device *dev =3D user_data;
> > +     const char *new_name;
> > +
> > +     if (!l_dbus_message_iter_get_variant(new_value, "s", &new_name))
> > +             return dbus_error_invalid_args(message);
> > +
> > +     if (!strcmp(new_name, dev->device_info.device_name))
> > +             goto done;
> > +
> > +     if (strlen(new_name) > sizeof(dev->device_info.device_name) - 1)
> > +             return dbus_error_invalid_args(message);
> > +
> > +     l_strlcpy(dev->device_info.device_name, new_name,
> > +                     sizeof(dev->device_info.device_name));
> > +     l_dbus_property_changed(dbus, p2p_device_get_path(dev),
> > +                             IWD_P2P_INTERFACE, "Name");
>
> Hmm, our convention is to do method_return, then signal.

Ok.

>
> > +
> > +done:
> > +     complete(dbus, message, NULL);
> > +     return NULL;
> > +}
> > +
> >   static bool p2p_device_get_avail_conns(struct l_dbus *dbus,
> >                                       struct l_dbus_message *message,
> >                                       struct l_dbus_message_builder *bu=
ilder,
> > @@ -430,6 +616,9 @@ static struct l_dbus_message *p2p_device_get_peers(=
struct l_dbus *dbus,
> >
> >   static void p2p_interface_setup(struct l_dbus_interface *interface)
> >   {
> > +     l_dbus_interface_property(interface, "Name", 0, "s",
> > +                                     p2p_device_get_name,
> > +                                     p2p_device_set_name);
>
> you don't want to use AUTO_EMIT to make things easier on yourself?  As a
> bonus, the previous comment would be fixed auto-magically.

I considered it but thought it doesn't cost us much to trigger the
signal ourselves and then we avoid sending it if the new name is same
as the old one.

Best regards
--===============0257660729513702766==--

