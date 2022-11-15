Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353047C
	for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 01:30:06 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id d20so15620116ljc.12
        for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 17:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrgCULNU4JNas0FVKi6HrCPwTGFhrTZ95UY6KUxb67I=;
        b=GDk/UCfHgtp9YfgeUVMXxmUt8aXNAqVnMl3SBXkV2Im3BOeOzZ1zjvFu0OUZ5xswCk
         ak3bTUWYrIwxToyucDu5KE+MSAC57N8D+UUN4PUPITMrK6CijGRV3/0BxZnryYs+PQgN
         lZSEYcWtYrjD0ipO0iGW4UpfyhAGZLG71Q5nf8KpdSODUkXzXHt4CX8wCpZDr2Wu7at3
         rzzaejGz1YYwzeFGu6ge3dXp9529+ABXyK2TKmECwz8WXv1/KrB2+K9rQAgIknzk3cUA
         qkofcabBoDSpF57vf24ZafTXaSwuuvw5r6WbKPq/e339mjATZzcvWoPIx9t3tip1zk7n
         uXnQ==
X-Gm-Message-State: ANoB5pm81bWEZmfmRRZEkS4VSsAClZBTAfaGLDwvBsnCLIovhCQ2KKv9
	dHsQTxthYU6q+pO8mP/u4EoAkp1BEWVwmQ==
X-Google-Smtp-Source: AA0mqf4LAtCX51QUGVCZwOyyL2ONmZ2lTSpXYtj0CApYUE2J7hjq8cfdqKJeollD0jOeHB1VuuQxHQ==
X-Received: by 2002:a2e:8e27:0:b0:276:be89:5616 with SMTP id r7-20020a2e8e27000000b00276be895616mr4742922ljk.347.1668475803595;
        Mon, 14 Nov 2022 17:30:03 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e8e75000000b0027711dbd000sm2184765ljk.69.2022.11.14.17.30.02
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 17:30:02 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id p8so22186213lfu.11
        for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 17:30:02 -0800 (PST)
X-Received: by 2002:a05:6512:3194:b0:4b4:981a:6f9d with SMTP id
 i20-20020a056512319400b004b4981a6f9dmr2386539lfe.584.1668475802382; Mon, 14
 Nov 2022 17:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221112011929.785388-1-andrew.zaborowski@intel.com> <a9af6470-6363-5362-f81d-0d612ab851da@gmail.com>
In-Reply-To: <a9af6470-6363-5362-f81d-0d612ab851da@gmail.com>
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Date: Tue, 15 Nov 2022 02:29:49 +0100
X-Gmail-Original-Message-ID: <CAOq732L4CaibiV=7rtWLEW0Wk9wGycLnwKB8=39TnmNwwby4KQ@mail.gmail.com>
Message-ID: <CAOq732L4CaibiV=7rtWLEW0Wk9wGycLnwKB8=39TnmNwwby4KQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] storage: Maintain the tls session cache object
To: Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

On Mon, 14 Nov 2022 at 21:03, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/11/22 19:19, Andrew Zaborowski wrote:
> > Any
> > sessions saved in relation to a specific network (ESS) should use group
> > names ending in the storage_get_network_file_path encoding of the
> > network's SSID+security type, so that storage.c can automatically drop
> > these cache entries if the network is being forgotten.
>
> It seems overkill to encode the full path into the group name.  Perhaps a
> hex-encoded SSID is enough?

It would be nice to include the security type, how about using the
file name without the rest of the path?

>
> >
> > Since the cache object needs to be freed when exiting, use
> > storage_exit() for that.  However, since there was already a
> > storage_init() and storage_exit() pair of functions, with storage_init
> > called from main.c conditionally on whether systemd encryption was
> > enabled, rename that storage_init() to storage_key_init() and declare an
> > IWD_MODULE to hanadle the calling of the new storage_init() and
> > storage_exit().  There's no warranty that those will be called before
> > and after any other module's init/exit but they're not necessary for any
> > functionality that other modules depend on.
>
> While what you have proposed here works fine, I do find it a little strange that
> storage_key_init() is being called before the modules were initialized (and thus
> storage_init() was called).  There's also a strange case where storage_exit()
> would not be called in case storage_key_init() failed, unlike the behavior now
> in $HEAD.

True.

>
> There seems to be no need for any of this at all since storage_init does
> nothing?

Right, it mainly only to improve the naming.

> It might be easier to just let storage remain special (not a module)
> as it is now.

Ok.

>
> > ---
> >   src/main.c    |  3 +-
> >   src/storage.c | 92 ++++++++++++++++++++++++++++++++++++++++-----------
> >   src/storage.h |  7 ++--
> >   3 files changed, 77 insertions(+), 25 deletions(-)
> >
>
> <snip>
>
> > +static void storage_network_remove_tls_sessions(const char *path)
> > +{
> > +     _auto_(l_strv_free) char **groups = NULL;
> > +     char **group;
> > +     size_t group_len;
> > +     size_t path_len;
> > +     bool changed = false;
> > +
> > +     if (!tls_session_cache)
> > +             return;
> > +
> > +     groups = l_settings_get_groups(tls_session_cache);
> > +     path_len = strlen(path);
> > +
> > +     for (group = groups; *group; group++)
> > +             if ((group_len = strlen(*group)) > path_len &&
>
> Hmm, >= path_len?

Ok, but using just the network's id as the group name wouldn't be a good idea.

Best regards
