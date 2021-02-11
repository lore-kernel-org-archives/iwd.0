Content-Type: multipart/mixed; boundary="===============9183340768913823986=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src: configure systemd-resolved's MulticastDNS= setting
Date: Thu, 11 Feb 2021 14:45:26 -0600
Message-ID: <2ce451ab-0dd3-e386-391e-bc3afd8be9f8@gmail.com>
In-Reply-To: <1f997b5df5730f363e52fde58d08c50bade87899.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9183340768913823986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

>> Is there a default?  If so, it should be in bold.  What happens if
>> this setting
>> is omitted?
> =

> If the setting is omitted, we don't touch the default value. Which

Ok, so there's no default that iwd should pick.

> appears to be false, but somebody could patch systemd-resolved to
> change that, so I wasn't sure if that should be documented here. I'll
> add that though.

So instead we may want to mention that if this setting is omitted, the =

systemd-networkd default is used.

>>> +	mdns =3D l_settings_get_string(active_settings, "Network",
>>> "MulticastDNS");
>>
>> This can return NULL if no MulticastDNS setting is found.  What
>> happens then?
> =

> Nothing happens, there's a null check in resolve_set_mdns().
> =


k, makes sense.   I somehow missed that originally.

>>> @@ -40,6 +40,7 @@
>>>    struct resolve_ops {
>>>    	void (*set_dns)(struct resolve *resolve, char **dns_list);
>>>    	void (*set_domains)(struct resolve *resolve, char
>>> **domain_list);
>>> +	void (*set_mdns)(struct resolve *resolve, char *mdns);
>>
>> should probably be const char *mdns
> =

> OK. Shouldn't the nearby `char **` parameters be `const char *const *`
> too, then?
> =


Possibly.  I think we resisted using the const variation since not many old=
 C =

hacks like to use such syntax.  So we kept using 'char **'.

For passing simple C-strings we like to be const-correct though.

Regards,
-Denis
--===============9183340768913823986==--

