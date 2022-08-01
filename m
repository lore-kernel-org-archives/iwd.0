Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26A7F
	for <iwd@lists.linux.dev>; Mon,  1 Aug 2022 18:09:26 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id i4so13972991oif.2
        for <iwd@lists.linux.dev>; Mon, 01 Aug 2022 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cI61EI/l8zEWDiOCjsKH9Lf+xU5PTZNoX17WHJnolk0=;
        b=S1aWqaI36wHY5a24MslyVKIrcdgSxnt5X3ndoJtsEDf4/ba/YloLPU1OdoBP0c0kFP
         iAmTUpDK2Z27TS0f5QnlaR6SXv/rqvpIdYBbIpW/FdWRRVZHENUthFC4BfFc8p5kqd/C
         FusrGmMcvQZ2g+oJIlOl/WfOwSNT3+gypO4nD1foW96VXWetuZPqJHnpSHaxKWosKSvy
         1o7E+99q7QC2VxtJi1lz18krPCk3NNpqaU/eXgecxwE3Igs92WwYg9oYkl20D9Y7Gd4G
         XK8WPLamtBcKf6LnCQjYlg2coQGvla6x+viMfuURrXexXP0yM/LQql4vVvyjQMjmvtoZ
         sOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cI61EI/l8zEWDiOCjsKH9Lf+xU5PTZNoX17WHJnolk0=;
        b=bmWGcMcMKsY+aKakUZJFL5ryGSfo+JyCsYmu9rfrPKNMr+qIlbkklcMX6/ToeQH5z/
         7nNI1WWzInqUFt5Vc/5iple7B8WqIb1wDGPHSHhgGlws7atObhxgzdwbrr6KwxaGN++Z
         ZSunO4QWPQ8Kzlrr2zz8TIWPAyQVRLfv8dXVPBRUokRv5W7QanASKo+UTWjLM65uDXAm
         WYNKlgOEaxyp/ZL7bgqaxiMiU443EoGzW78PCTpF9Z04aJT9rp0vnoW7Q+TvXvY717RJ
         fVdbf6x8Y2I36EVyT4k0lsXbkI66K7bBMIM4451E3vHVOCS6z+Vjj6BjbL0mpVYNI2TB
         07Pg==
X-Gm-Message-State: AJIora9ueW6fSAvq84O/lfyZcETfrmM1xEtOZ8muZGtc7Q7LUe0Umb8N
	JZGpDEJv4EHGjhnrgsBvyWP3NcC9otb2HtzPB2E=
X-Google-Smtp-Source: AGRyM1vNIKKzLx7+Uj9ZQ39GQEFSwyKOdn7ndnt2m3aDJ2+BmmE+veP9jZAIWPHwGdLy001n2Y5q9VpkNgsJQRrww90=
X-Received: by 2002:a05:6808:1708:b0:335:1b16:fb09 with SMTP id
 bc8-20020a056808170800b003351b16fb09mr7275198oib.7.1659377365266; Mon, 01 Aug
 2022 11:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220801100631.41605-1-mjohnson459@gmail.com> <6bc199e2-2f40-b192-9de6-30fceb2510ea@gmail.com>
 <CACsRnHULBH=jmCiG4=kczJALPsy7Whx+TmDf-JhQryyc5GwBow@mail.gmail.com> <c012837a-9d79-1909-dd2f-3fcd98828d52@gmail.com>
In-Reply-To: <c012837a-9d79-1909-dd2f-3fcd98828d52@gmail.com>
From: Michael Johnson <mjohnson459@gmail.com>
Date: Mon, 1 Aug 2022 19:09:14 +0100
Message-ID: <CACsRnHW4N1aBkcJyeAppgMj1bqV8t3V_BwYrjy+MB=S0uepaWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] netdev: Add logging for CQM messages
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

On Mon, 1 Aug 2022 at 18:24, Denis Kenzior <denkenz@gmail.com> wrote:
> I wonder if we should report this over D-Bus instead?  I mean you can always
> setup your own SignalLevelAgent, or we could even add more reporting via
> StationDiagnostic interface?

I actually do record the signal level separately but it's stored in an
annoying binary format so access is more painful :(. This was just to
make things easier and reduce the jump from wpa_supplicant to iwd for
anyone on plain ubuntu etc. I can understand why you don't want the
spam though.

> Right, but I think it sets a single CQM threshold, not multiple like we (might)
> do.  Also, wpa_s is very spammy since it is really (only) meant for testing wifi
> implementations in a lab ;)

haha fair. Of course, it's still the default on most linux systems ;).

> > changes are harder to make. If the `info` level becomes to verbose, maybe
> > iwd could set the default logging level to `warn` to reduce spam?
>
> You can use a glob match for the -d flag.  Something like:
>         #iwd -d '*Signal change event*'
>
> So you can make the rssi messages as 'debug', and have iwd only print those you
> want.  Multiple globs are supported too, separate them by ':' or ','.

That's a smart idea although as a user i feel like you only ever know
what messages are important after the fact.

>
> Regards,
> -Denis

What would you like to do with the patch? I'm happy to drop it if its
too spammy or we can lower the level to debug? Or make it only print
when the threshold changes.
Are you happy with the packet loss and beacon loss events or are they
too much as well?

Regards,
Michael
