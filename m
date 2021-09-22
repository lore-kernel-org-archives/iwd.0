Content-Type: multipart/mixed; boundary="===============2401755107594131171=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netconfig: Add IP configuration properties on Station and
 P2P
Date: Wed, 22 Sep 2021 17:32:21 -0500
Message-ID: <35753f1a-ca6b-4730-96ce-43e27d9cd046@gmail.com>
In-Reply-To: CAOq732K5p9ctz2ORSULxQ0auwv8q+gdO6vgiBWoW3watGnHH7w@mail.gmail.com

--===============2401755107594131171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> @@ -270,23 +300,25 @@ static int netconfig_set_dns(struct netconfig *ne=
tconfig)
>>>        char **dns_list;
>>>        const struct ie_fils_ip_addr_response_info *fils =3D
>>>                netconfig->fils_override;
>>> +     struct l_dbus *dbus =3D dbus_get_bus();
>>>
>>> -     if (!dns4_list && !dns6_list)
>>> -             return 0;
>>> +     if (dns6_list) {
>>> +             dns_list =3D l_malloc(sizeof(char *) *
>>> +                                     (n_entries4 + n_entries6 + 1));
>>>
>>> -     dns_list =3D dns4_list;
>>> +             if (dns4_list)
>>> +                     memcpy(dns_list, dns4_list,
>>> +                             sizeof(char *) * n_entries4);
>>>
>>> -     if (dns6_list) {
>>> -             dns_list =3D l_realloc(dns_list,
>>> -                             sizeof(char *) * (n_entries4 + n_entries6=
 + 1));
>>>                memcpy(dns_list + n_entries4, dns6_list,
>>>                        sizeof(char *) * (n_entries6 + 1));
>>> -             /* Contents now belong to dns_list, so no l_strfreev */
>>> -             l_free(dns6_list);
>>> -     }
>>> +     } else
>>> +             dns_list =3D dns4_list;
>>>
>>>        resolve_set_dns(netconfig->resolve, dns_list);
>>> -     l_strv_free(dns_list);
>>> +
>>> +     if (dns6_list)
>>> +             l_free(dns_list);
>>
>> Why are you doing all this when you can just check for dns[4|6]_list bei=
ng
>> changed prior to building the list for submission to resolve_set_dns?
> =

> Do you mean why is the code calling resolve_set_dns() even if the
> values haven't changed?  Mostly to keep the current behaviour.
> =


No.  You're building a brand new dns_list so that you're not messing with t=
he =

dns4_list / dns6_list because you want to check those for changes & send =

PropertyChanged signals.  But you can take care of the PropertyChanged sign=
als =

up front (and you probably want to prior to the 'both lists are NULL' check =

anyway).  All the changes above are not necessary.

Regards,
-Denis
--===============2401755107594131171==--

