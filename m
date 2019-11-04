Content-Type: multipart/mixed; boundary="===============2103733075674766552=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] wiphy: add beacon bits to RM Enabled Capabilities
Date: Mon, 04 Nov 2019 16:35:34 -0600
Message-ID: <c6e845c6-86a5-1368-7d88-a356accef9cb@gmail.com>
In-Reply-To: <b285a0430494b28d14d44e2a2d4d1cbdba1af39d.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2103733075674766552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>>> +	/* Bits: Passive (4), Active (5), and Beacon Table (6)
>>> capabilities */
>>> +	wiphy->rm_enabled_capabilities[2] =3D 0x70;
>>
>> Do you really mean to add all of these or just the Beacon table one?
> =

> Yeah this was intended. This lets us support passive and active scan
> requests. Did you only want to allow table measurements?
> =


Ah no, this is fine.  I now realize I mixed up Beacon Table and Beacon =

Request.  So ignore this, the commit is fine.  I'll take it in the next =

version.

Regards,
-Denis
--===============2103733075674766552==--

