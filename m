Content-Type: multipart/mixed; boundary="===============6760377316833819095=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH] scan: don't send the same scan request twice
Date: Mon, 01 Jun 2020 13:32:16 +0200
Message-ID: <f66393c0-f602-457e-643a-4cc2e6efe924@bang-olufsen.dk>
In-Reply-To: <CAOq732LjDvnJ-PpLEYOrJ=Un43N0JHOE_n2Zj_Amrvob2F=FwQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6760377316833819095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/31/20 12:26 AM, Andrew Zaborowski wrote:
> Hi Alvin,
> (resending this to the list)
> =

> On Fri, 29 May 2020 at 15:57, Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>=
 wrote:
>>
>> If start_scan_next_request() is called while a scan request
>> (NL80211_CMD_GET_SCAN) is still running, the same scan request will be
>> sent again by mistake. Add a check in the function to avoid sending a
>> request if one is already in progress.
> =

> Do you know if start_scan_next_request() was called from scan_resume
> in your case?  In all other callers we can be sure start_cmd_id is
> already 0, so scan_resume may need to have these checks added instead.
> I think it should check that !sc->start_cmd_id && !sc->triggered &&
> !sc->get_scan_cmd_id because the scan_resume() call can come in during
> any of those phases.

Yes, in my case it was getting called from scan_resume(). I agree that
it's the only point where start_scan_next_request() might get called
while start_cmd_id !=3D 0, so what you suggest would also fix the crash I
referred to.

But it seems to me that scan_resume() should not really concern itself
with the internals of the scan request dispatching. Given that
start_next_scan_request() already returns true early if sc->suspended or
if sc->state !=3D SCAN_STATE_NOT_RUNNING, it seems like an optimistic "try
to send the next scan request if it is possible" function. Therefore I
put the extra check (sc->start_cmd_id !=3D 0) there in the same vein.

What do you think?

> =

> BTW you mention NL80211_CMD_GET_SCAN above, I think you meant
> NL80211_CMD_TRIGGER_SCAN.

Yes, you are right. I will fix this when I send a v2 patch.

> =

> I also wonder if scan_common() should check sc->suspended like
> start_scan_next_request() does.

I guess it should, no?

Perhaps rather than having duplicate checks for the same stuff in both
scan_common() and start_next_scan_request(), we could have scan_common()
enqueue its scan request and just call directly into
start_next_scan_request()? Then we can put all the relevant checks in
one place (start_next_scan_request()), namely: !sc->suspended &&
sc->state !=3D SCAN_STATE_NOT_RUNNING && !sc->start_cmd_id &&
!sc->get_scan_cmd_id.

The only problem with having scan_common() use start_next_scan_request()
is that, currently, scan_common() deliberately removes the destroy
callback from the scan request if scan_request_send_trigger() returns an
error:

    if (!scan_request_send_trigger(sc, sr))
        goto done;

    sr->destroy =3D NULL; /* Don't call destroy when returning error */
    scan_request_free(sr);

I'm not quite sure what the reason for this is, but maybe you can comment?

If you like the idea of moving most of the pre-scan-trigger checks into
one place, then I can prepare a patch for you to see exactly what I
mean. But if you think it's overkill then I will just resend a v2 of
this minimal change to address the specific problem (duplicate scan
request & segfault).

Kind regards,
Alvin
--===============6760377316833819095==--

