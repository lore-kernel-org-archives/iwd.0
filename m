Content-Type: multipart/mixed; boundary="===============7479609364781308990=="
MIME-Version: 1.0
From: Kourt, Tim A <tim.a.kourt@linux.intel.com>
Subject: Re: [PATCH 1/2] auto-t: remove scanning wait from
 testConnectAutoconnect
Date: Wed, 06 May 2020 10:02:12 -0700
Message-ID: <6790b6f3-1303-6c8a-6696-c30644f0b68f@linux.intel.com>
In-Reply-To: <CAPv5Ue65n+fHNQterpTc2GTnr9bKh_8k8OKjqd1nCuyU8h-hrg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7479609364781308990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>>> -        condition =3D 'obj.scanning'
>>> -        wd.wait_for_object_condition(device, condition)
>>> -
>> What if the scan has never started yet? Since iwd is started from
>> Python, it looks suspicious that it goes through the scan before it hits
>> the conditional wait a few lines down the script. Perhaps changing to
>> wd.list_devices(1) API has introduced this issue. Would it help to
>> increase the conditional wait time out so it goes into the second round
>> of scans for these certain cases?
> I can try increasing the timeout, but I think relying on periodic
> scans for this autotest isn't the best way to go about it. I will try
> explicitly scanning via dbus, otherwise you are just hoping that a
> periodic scan was started. This timing will vary slightly between
> systems which is why I think I am hitting this.
The purpose of this autotest and of the one with the hidden networks is =

to exercise auto-connection without an explicit call from Dbus =

(different code paths).
--===============7479609364781308990==--

