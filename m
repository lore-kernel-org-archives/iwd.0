Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579482755F4
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600568; cv=none; b=NfZoeUJT+tAGSygAXcLe4NNAlGBHnZ1dOkm8qYobVZviqyw9bW3FpCXXe63JyI2zUDclIE3z/ECDCT9cLg03Fngc7jVFA9bDJLU7qJrr68S0iVAC41NoCz77dO2FmrGadyxbiVoJboMg8KsHeERn8z/ZqPxvUhduERfQHhVHHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600568; c=relaxed/simple;
	bh=0JzcXhsBVkLDCB7QqNzqxng3q0hqPTZdnk52FKbFUH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkw61SihoDb/HWCzK8hZeRC/nK5y2niPkZ2cFU/xDNglyJOYI3kGz0rxB2EPzpwf/nemcD5zwxCQnxIFzH0RmDQdj5UaiFCg87bcdba3VrYXJFvWFKnI3AXle0F8nDRN45pDWV3qu35pPO5uXr5jj8PlQicLEs/gp0ltYhFEDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5db2d767f2so143548276.2
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 12:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600566; x=1741205366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/9eX7qxA7N7qlrJv8z6JC/b4yue/alEUIJW3NMzzII=;
        b=f9cXJQ42J6sPSJ7/aomx9Yus/hjrlyEtoljLHQhaTbkHFnxgT8om4NhzVJ8O/5x0S1
         mU+fY7kwKlBlC9alKEls/0oze4XLdWCU6uEPhBjBFwAH8bkMbVQbx0NhgzgjbJ4gP/Xp
         FAI2h8XIRO+YGUW2+pM6s/myTroirHjGpl1O1C8iZFXwpaQ1DtiZ4byjbnURD7nlm2s5
         u/nIuH3RSgAXoEZGAHwRhGRCB7Sbd3Xwv8383xQY9GnqV6h/29dleblidYYgMyUygFxw
         h1dzo7pOTbrClzMMAk0gwfpvPikuAEg42IF2VupZHfRgzrD8XqKNG7mRZeAb/ty1rzQq
         Ulzg==
X-Gm-Message-State: AOJu0YyZ3HuY9p77O0K659FlpTJ/xvJTjTqmml+/Nr64pOYjiVIQK4I9
	Urkfmgf5a38VVKrlG/P5Gr1ScmCbAdlC1Nta6LFvWhyGU6h2RoCQ4cDvtw==
X-Gm-Gg: ASbGnctIYM7K1F0GMqhsbRWtymnSI+ukZT5ajNjaCRV1V5aHWuVZk/s0FeLe1d9Kt6Q
	JTn5vinSWFO3jHHd9P5fDL00aQN9wUECVZ5vmNkunJEhSKYLsi4vh8NOo6jytiIzkmfiVUst8R0
	+mF8HnoFXefnNdFnbMQJbY1QCK0Jlv6KHKqxxNLhKG6M9rSKePRvsDmDMFpdhowv4Le5PTPdAYh
	N25g1KHwMd5q3EdKMVhXQYOm1RUzOSB/hV425Z6RIWEoNcNro/QaiCTQRdolNHQ0pccArSC1uew
	WOwykrKj/4iZK58rHfJawjBo2yNP/islR7BU9+R2fcto7nQFgFR2119XwDB7yqLkyBL4Hg==
X-Google-Smtp-Source: AGHT+IFSRtorDVUdpQbvdpVNePbFkr6Hv73zpxbo6rwVvVJb+5Iwi9QfNS1w81HWu9sBXVGiwd14cg==
X-Received: by 2002:a05:6902:15ca:b0:e58:33aa:3ac7 with SMTP id 3f1490d57ef6-e608a820f2amr4500024276.44.1740600565989;
        Wed, 26 Feb 2025 12:09:25 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e609f6aee73sm69345276.47.2025.02.26.12.09.25
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:09:25 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5db2d767f2so143536276.2
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 12:09:25 -0800 (PST)
X-Received: by 2002:a05:6902:2b05:b0:e5a:cece:f38d with SMTP id
 3f1490d57ef6-e608a6bf64emr4191229276.13.1740600565445; Wed, 26 Feb 2025
 12:09:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADXxVSKD-YKOxt+=b919QWFHnU7QcSWnEwfb8xU-JGn=xVrbbg@mail.gmail.com>
 <4ec69c46-bbc1-4a05-9d7a-18c1d4d249d1@gmail.com> <CADXxVS+xAeGUiwGTe7L0Rr+OtxqRdvZ2AwwhfgpegB8h-dA9TQ@mail.gmail.com>
 <CADXxVS+iBcBeyj7geJ0jMCrT3wP+YBqXcGJ98oa5KEPUGa7ncg@mail.gmail.com> <d09520d4-997c-4f29-9116-6305aea7af5d@gmail.com>
In-Reply-To: <d09520d4-997c-4f29-9116-6305aea7af5d@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Wed, 26 Feb 2025 13:09:14 -0700
X-Gmail-Original-Message-ID: <CADXxVSLVWQji1PO4fi7_xc5HUocyqD3H5Fy7tAGkBagW1_Zw7A@mail.gmail.com>
X-Gm-Features: AQ5f1JrzG800jkWWxyDrez5wceJ0IceXz6JAETNDayoejkKHZyEER1834nuIDB4
Message-ID: <CADXxVSLVWQji1PO4fi7_xc5HUocyqD3H5Fy7tAGkBagW1_Zw7A@mail.gmail.com>
Subject: Re: Does a AP get blacklisted if it fails auth too many times?
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> >
> >
> > I did see after this event:
> >   2025-02-26 02:47:54.473847839  event: state, old: autoconnect_quick,
> > new: disconnected
>
> This is due to something issuing a DBus Disconnect() call:
>
> 2025-02-26 02:47:54.473604731  src/station.c:station_dbus_disconnect()
>
> If IWD gets a disconnect from DBus that actually disables autoconnect
> until a DBus Connect() call. If this is being done from any automated
> tooling you have to be _very_ sure you manually connect again, otherwise
> IWD will just sit there forever.
>

I had 2 dbus disconnects
2025-02-26 02:47:02.070527979  src/station.c:station_dbus_disconnect()
2025-02-26 02:47:54.473604731  src/station.c:station_dbus_disconnect()

Which seem to line up with Connman
2025-02-26 02:47:02.050964651  connmand[2131]: Interface wlan0 [ wifi
] error "invalid-key"
2025-02-26 02:47:02.053646583  connmand[2131]: Interface wlan0 [ wifi
] state is failure
<SNIP>
2025-02-26 02:47:54.453669827  connmand[2131]: Interface wlan0 [ wifi
] error "invalid-key"
2025-02-26 02:47:54.457083997  connmand[2131]: Interface wlan0 [ wifi
] state is failure

It probably is the one sending the dbus disconnect, doh.  For this
product we aren't actually using connman (version 1.43) for much, but
got carried along the way.  A little annoying that we are doing
everything with iwd and connman looks to be seeing the invalid key and
causing a disconnect.  Originally we were doing our provisioning with
connman using dbus, but switched to iwd directly because there seemed
like issues staying in sync.
