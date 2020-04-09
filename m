Content-Type: multipart/mixed; boundary="===============3025937187370694875=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems attempting to use ad-hoc mode, link state remains dormant
Date: Thu, 09 Apr 2020 16:31:16 +0000
Message-ID: <a838c6ae-4994-5a11-2578-19aa7240913e@gmail.com>
In-Reply-To: <VI1PR01MB51672539A45DA230833C35A788C00@VI1PR01MB5167.eurprd01.prod.exchangelabs.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3025937187370694875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diego,

>> The tricky part is that adhoc doesn't initialize its own rtnl object, so
>> I need to think about a good fix for this.
>>
> =

> Thanks for the information, indeed it looked to me that there was somethi=
ng missing but I could not really figure it out for sure from the code. I d=
o not think I can help out there.

This should now be fixed upstream.

Regards,
-Denis
--===============3025937187370694875==--

