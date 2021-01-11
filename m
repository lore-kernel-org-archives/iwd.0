Content-Type: multipart/mixed; boundary="===============1803804010620248138=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] netdev: add netdev_get_station
Date: Mon, 11 Jan 2021 15:08:43 -0600
Message-ID: <456b84ee-ab05-6a82-10a5-b00d20adedf7@gmail.com>
In-Reply-To: <0e4dd87f7c34ec5ffc5e7a3e04d3ce726bb98719.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1803804010620248138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>>> +int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
>>
>> Do you want to add a convenience method to grab the current
>> station?  The mac
>> parameter is for cases where you might have multiple ones, like AP.
> =

> I could, although its not too bad just passing in handshake->aa... But
> if you want a current station API and a separate one for AP I don't
> mind either way.
> =


I was just thinking that you probably can keep this method and just add a =

wrapper (netdev_get_current_station or something) that would just call =

netdev_get_station appropriately.  But I'm fine either way.

Regards,
-Denis

--===============1803804010620248138==--

