Content-Type: multipart/mixed; boundary="===============6792076333831666185=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] netdev: Pass a reason code with
 NETDEV_EVENT_DISCONNECT_BY_*
Date: Tue, 11 May 2021 18:27:53 -0500
Message-ID: <42f04381-fec4-8a53-5bdc-3eec3ce71716@gmail.com>
In-Reply-To: <CAOq732LWfdibQg8wsRSAoKYY3WZh3874dbyyV8jv6vmD-N81iA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6792076333831666185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 5/11/21 5:57 PM, Andrew Zaborowski wrote:
> On Wed, 12 May 2021 at 00:34, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 5/11/21 4:56 PM, Andrew Zaborowski wrote:
>>> On Tue, 11 May 2021 at 18:36, Denis Kenzior <denkenz@gmail.com> wrote:
>>>> On 5/10/21 5:12 AM, Andrew Zaborowski wrote:
>>>>> Station callbacks expect a reason code (as opposed to status codes) w=
ith
>>>>> this event type.  This shouldn't matter a lot because
>>>>> station_disconnect_event() only actually looks at the value during
>>>>
>>>> I'm not sure why station is written this way.  I'm pretty sure that ca=
lling
>>>> station_disconnect_event() for NETDEV_EVENT_DISCONNECT_BY_SME() is the=
 wrong
>>>> thing to do.
>>>
>>> That is currently the only use of that function though.
>>
>> No, we have DISCONNECT_BY_AP and DISCONNECT_BY_SME.  DISCONNECT_BY_SME s=
hould
>> pretty much imply station_disassociated() should be called since we shou=
ld never
>> receive this event when we're in the connecting state.
> =

> I wouldn't rely on that, if the kernel doesn't pass
> NL80211_ATTR_DISCONNECTED_BY_AP it could mean that the AP sent
> something that triggered the kernel to disconnect (possibly before

I suppose it might be possible, but wouldn't you treat it as a connect fail=
ed =

and not a disconnect_by_sme?  That is what we do if Auth/Assoc times out fo=
r =

example.

> handshake complete).  For us we mainly care that we can't use this BSS
> and should try a different one next time.

But we need to make a best attempt to guess as to why it failed.

 From what I gather, in this particular case, the AP just sends a Deauth af=
ter =

PTK2/4 packet doesn't pass the MIC check.

Regards,
-Denis
--===============6792076333831666185==--

