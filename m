Content-Type: multipart/mixed; boundary="===============3515103393814733043=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] scan: don't send the same scan request twice
Date: Mon, 01 Jun 2020 15:20:59 +0200
Message-ID: <CAOq732LFMpVzcGGEvuXjXWgXOTRzSQPOzBoDNLNHZRNQURZpCg@mail.gmail.com>
In-Reply-To: <f66393c0-f602-457e-643a-4cc2e6efe924@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3515103393814733043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jun 2020 at 13:32, Alvin =C5=A0ipraga <alsi@bang-olufsen.dk> wr=
ote:
> On 5/31/20 12:26 AM, Andrew Zaborowski wrote:
> > Do you know if start_scan_next_request() was called from scan_resume
> > in your case?  In all other callers we can be sure start_cmd_id is
> > already 0, so scan_resume may need to have these checks added instead.
> > I think it should check that !sc->start_cmd_id && !sc->triggered &&
> > !sc->get_scan_cmd_id because the scan_resume() call can come in during
> > any of those phases.
>
> Yes, in my case it was getting called from scan_resume(). I agree that
> it's the only point where start_scan_next_request() might get called
> while start_cmd_id !=3D 0, so what you suggest would also fix the crash I
> referred to.
>
> But it seems to me that scan_resume() should not really concern itself
> with the internals of the scan request dispatching. Given that
> start_next_scan_request() already returns true early if sc->suspended or
> if sc->state !=3D SCAN_STATE_NOT_RUNNING, it seems like an optimistic "try
> to send the next scan request if it is possible" function. Therefore I
> put the extra check (sc->start_cmd_id !=3D 0) there in the same vein.
>
> What do you think?

It would probably work.  The downside is that we're possibly
re-checking conditions that we already know are fulfilled, the upside
is possibly readability.

You'd then need to change the commit message to say it's refactoring
start_next_scan_request.

>
> >
> > BTW you mention NL80211_CMD_GET_SCAN above, I think you meant
> > NL80211_CMD_TRIGGER_SCAN.
>
> Yes, you are right. I will fix this when I send a v2 patch.
>
> >
> > I also wonder if scan_common() should check sc->suspended like
> > start_scan_next_request() does.
>
> I guess it should, no?
>
> Perhaps rather than having duplicate checks for the same stuff in both
> scan_common() and start_next_scan_request(), we could have scan_common()
> enqueue its scan request and just call directly into
> start_next_scan_request()? Then we can put all the relevant checks in
> one place (start_next_scan_request()), namely: !sc->suspended &&
> sc->state !=3D SCAN_STATE_NOT_RUNNING && !sc->start_cmd_id &&
> !sc->get_scan_cmd_id.
>
> The only problem with having scan_common() use start_next_scan_request()
> is that, currently, scan_common() deliberately removes the destroy
> callback from the scan request if scan_request_send_trigger() returns an
> error:
>
>     if (!scan_request_send_trigger(sc, sr))
>         goto done;
>
>     sr->destroy =3D NULL; /* Don't call destroy when returning error */
>     scan_request_free(sr);
>
> I'm not quite sure what the reason for this is, but maybe you can comment?

The reason is that the scan_passive, scan_active, etc. entry points
are not assumed to call the destroy callback synchronously. When they
return an error it's assumed that none of the resources passed as
parameters were used and no callbacks happened, i.e. funcions have no
side effects on errors, afaik it's just a convention.

>
> If you like the idea of moving most of the pre-scan-trigger checks into
> one place, then I can prepare a patch for you to see exactly what I
> mean. But if you think it's overkill then I will just resend a v2 of
> this minimal change to address the specific problem (duplicate scan
> request & segfault).

You can try it and we'll see what Denis thinks about it.

Best regards
--===============3515103393814733043==--

