Content-Type: multipart/mixed; boundary="===============5592300647367530795=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] ip-pool: Add subnet address selection logic
Date: Wed, 26 May 2021 15:06:55 -0500
Message-ID: <e07fe248-5353-eeff-d766-36487e2c34f4@gmail.com>
In-Reply-To: <c119acaf-d675-fca9-62a4-87fcefca4000@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5592300647367530795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> +int ip_pool_select_addr4(const char **addr_str_list, uint8_t prefix,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct netdev *netdev, uint32_t *out_addr);
>> =C2=A0 const struct ip_pool_addr4_record *ip_pool_get_addr4(struct netde=
v *netdev);
>>
> =


Oh, and another thing.  Can this just return us an l_rtnl_address? The =

address/prefix is known and that is basically all you need for the =

l_rtnl_address object. That way it can be used directly in l_rtnl_ifaddr_ad=
d / =

delete functions.

Regards,
-Denis
--===============5592300647367530795==--

