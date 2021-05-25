Content-Type: multipart/mixed; boundary="===============4569807364437302751=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Tue, 25 May 2021 18:53:44 -0300
Message-ID: <fee08251-7837-b7bf-61b8-76257aaf30ca@collabora.com>
In-Reply-To: <20210519073239.u43a27gc4r3wmivh@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4569807364437302751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 5/19/21 4:32 AM, Daniel Wagner wrote:
> Hi,
> =

> On Wed, May 19, 2021 at 08:58:01AM +0200, Marcel Holtmann wrote:
>>> So AFAIU from the above, the patchset is implementing wpa_supplicant
>>> WPA3-SAE support in the right place: wifi plugin. Any change required? I
>>> understand that documentation should be updated probably, anything else?
>>
>> if you need to update the Service API documentation, then you are
>> doing something wrong.
> =

> The only thing you need to do is to extend the wifi.c plugin to set to
> SAE if it's available when PSK is selected via the D-Bus API. As Marcel
> pointed out this should not be exposed to the user.

Sorry, I'm not sure how to address that. I might be missing something
here, so quick questions:

* Which D-Bus API call would set the service security to PSK even if
it's registered as SAE capable?
* Why is this a requirement and why should that go in plugin/wifi.c?

Thanks a lot for your help,
Ariel
--===============4569807364437302751==--

