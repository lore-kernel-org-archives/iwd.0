Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01522A4A
	for <iwd@lists.linux.dev>; Wed,  5 Apr 2023 10:26:32 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 184so6752765pga.12
        for <iwd@lists.linux.dev>; Wed, 05 Apr 2023 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems.com; s=google; t=1680690392; x=1683282392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKGtdb9FZnrKjD+IIH4pejvVIqfVriAMa3BFDWMvqVA=;
        b=ZmdCpOOPhC1PDYreyXLKFKuJi4ZE78NJFnabTpmq7KEv16WyPtXX+mr4YW4a/bJvS0
         nrRk0NIQNUan/K3PYTcr4me1pWMMNUY9Dd/IQ8to8D3G1K2tYAPVZYsgnh20GypL9aml
         KolKMX4htweIseXSkTWC4T0qozcTyWl0/uA+UBbVWzDtGLzBx/zFInYW4El6S6JkhmWr
         sZ2xSa9NzwvHbnXy3h9gBD8HVn1swMJAX9z2hqjwGKkVt9JtCyn8yJo99MNrvEnA7d5h
         0mtHBzQn41/T739Ei9xtgFHieeByby3EXcJzfuNNDU+sbG3004KUBfX5FW4o24X96kF2
         rSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680690392; x=1683282392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKGtdb9FZnrKjD+IIH4pejvVIqfVriAMa3BFDWMvqVA=;
        b=fNHFaGYYokvv5ifMi978tG+kTvy6Pey0tM7Ikc74e5A65XeS3oFXMC9VXKcOIS+q9P
         v4VMaO1JAhaY4F7/sghViE7FSHSJVBo8P1CytcdJsw8DuQ0dd3HGi8PIaQhXpXx7KX0j
         iWbJrNCQErvpZQiuq94/4G9ONp2TqMKJU3ncgu+L4dIVJtKRHHvQJrsVkqzWwjGGsZAR
         jWQ9iMdnXnlHi8Z/mQ4kFpMRPbuZfglftz7OxC58ULvo9+WxvjQ0VhEjhRDsedNtRQz0
         nFgLbEectbhpYi12NzJt0CCM1dJCzu8moIOvjl9m0iet7JjdPIcOv0oMdKZRrDJJ6LsT
         Fu7A==
X-Gm-Message-State: AAQBX9f5pegtbzNx+lUnBUtnsbJYXRUXvmR409P6RjUgSrrPI+8vEcRO
	7AVimpBC2gYxQ8D9D/buMUHbZvqluIrtdnbphOVk8w==
X-Google-Smtp-Source: AKy350YhHqA14JoYFOYVYfHdJFSFnZw7trNI7/c+I62QT1uDLXcXFwaLxHLXcZErh9m0/VRrfSVK4IkNZH4ppRb7WKw=
X-Received: by 2002:a05:6a00:2313:b0:593:fcfb:208b with SMTP id
 h19-20020a056a00231300b00593fcfb208bmr3021526pfh.3.1680690392134; Wed, 05 Apr
 2023 03:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a1840fea7c5e4233ac102e450e7ef873@kelio.com> <77b8a647caac0e132fdbdf7c8896baf0e37f65ba.camel@gmail.com>
 <a187bab1a26a4adba9be33160de6def1@kelio.com> <14aa2e7b806bed3b7f30889e5502ef90434ccfc4.camel@gmail.com>
 <ad8d8d72899049dbb106ec49c2f69517@kelio.com>
In-Reply-To: <ad8d8d72899049dbb106ec49c2f69517@kelio.com>
From: =?UTF-8?Q?Joakim_Lotseng=C3=A5rd?= <joakim.l@orbital-systems.com>
Date: Wed, 5 Apr 2023 12:26:06 +0200
Message-ID: <CAELJisxhoTV1-q0vk8qxjXgNvjJ7_j0vHvDg26rdABKA00n65g@mail.gmail.com>
Subject: Re: No Agent registered when calling Connect method
To: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 27 Mar 2023 at 09:24, clement.legoffic@kelio.com
<clement.legoffic@kelio.com> wrote:
> > >
> > > Why can't I use the IWD agent which iwctl use ?
> >
> > You can use iwctl as the agent, and you already did this to connect above.
> > What's the problem doing it this way?
>
> Actually it is not a problem, I just want to only use the IWD D-BUS interface in order to connect to a WPA2 Network.
> My use of iwctl is here to confirm It can works.
> I need to register a Agent in order to calculate the PSK to make the ssid.psk config file but I cannot figure out how Agent registering works.
> What I understand in the python example is that I should create my own Agent, that implements the same method and properties form the documentation.
> And so I was wondering if only for test purposes I can be able to use the iwctl Agent in order to connect to my WPA2 network.
>

If it helps you, we have written an MIT-licensed iwd_client lib, based
on libell for DBUS. Written in C. It is intended to be used by some
stand alone device (embedded device) to scan and configure SSID+WPA
PSK from some daemon. In our case it is over a bluetooth connection.
Sadly, it is only half of the daemon we have for this, so there is no
example, nor any more documentation than the code itself. I can't
support you with it. Code is below to use as you want. It has a basic
iwd_client_connect("ssid", "key") and handles agenting in the
background. It does need the libell mainloop to be running.

https://github.com/orbital-systems/iwd_client
