Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3C3C14
	for <iwd@lists.linux.dev>; Fri,  1 Jul 2022 17:05:46 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id u199so4386181oie.0
        for <iwd@lists.linux.dev>; Fri, 01 Jul 2022 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=yLVuVQZEnnA0cG996si9iYuLNFZeVzdeCkhNt0AP8/c=;
        b=ZwABlfVf94jW3838DX6Bgihn7GULGl+MhFy3WvZFh0dUBzvQWxXY7S++TY+nQCxHjU
         IBFzkZkTypP6RP+aIU1k6u/2Cp8NiBIKpDjlPx4JnhIw9zJDuvALFChLVPgkwJ2HE5VR
         2hajTtJvTvymmfaLqnQohygw0eSaZ06oIHbufHz7bv4GoqvNgvxQCu3iGjTvtS7JUUt1
         ZRB8nuXvChf7jOr0hn1YbvCKFNwJupzRcxuIhElEQXE5wcLStdsF7qaI5G9JzN0ip280
         Qljq+iQujC+yQHR+zthA8yQAvG1Kef+hLlwYkzVETrmg4eKyu4bzJ22BABAEJsXniPa9
         vKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yLVuVQZEnnA0cG996si9iYuLNFZeVzdeCkhNt0AP8/c=;
        b=CAAYhh5Zlunuhj8l6tYVY/toMJoP/MGuPQYkQwUtYIjwrFNGUCy2Q/lFZ/acnzAO2E
         UjbONiBXyf4IIjmPfgjJ7x0XuXsQqsr7Cg+o4WYoThx34SBqEq0u0YusPj5dAs6JZ1hz
         9In+rOnxG/RHNMi6e7GKGTzwVgc/lcDiR8wzs5kuH9hFPM4dPtdsl4QwiAIwg+BLf3Sz
         DB5WV9Y8PtvamwK33mVBf1p8sP8kPrl/XTD4imeURW0nem0GtEs/MDgRaUv1k29NV7K2
         OFGVRL09UtSakSvp4X7MgmS0wbtE9uHCHZVTFktkDb4yL+a09orsRqCIM0lSQjPYKBsq
         Qyfg==
X-Gm-Message-State: AJIora+6syncC/qEWXypLXpCk4+bVqeLhdXQoVQR7G8GUf6Yjp0+T+fS
	zrCkz3bWGdAjokPCO4uthDF1B3xjY+Ziv8Pt
X-Google-Smtp-Source: AGRyM1terhvenzInCUWQomK+xgqov1//rT/xFiz+5c5Lwpmcvx+kJylJqR3oMY8IWgg5ejOu2lFdew==
X-Received: by 2002:a05:6808:219b:b0:335:751c:84a3 with SMTP id be27-20020a056808219b00b00335751c84a3mr10993421oib.113.1656695145356;
        Fri, 01 Jul 2022 10:05:45 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u5-20020a4a9705000000b0042568efdaccsm12500764ooi.15.2022.07.01.10.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 10:05:45 -0700 (PDT)
Message-ID: <4194aaf0-55ad-22ee-8fb4-93b1e13d2acf@gmail.com>
Date: Fri, 1 Jul 2022 12:00:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ap: remove diagnostic interface when netdev goes down
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220701163108.450486-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220701163108.450486-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/1/22 11:31, James Prestwood wrote:
> This fixes a crash associated with toggling the iftype to AP mode
> then calling GetDiagnostics. The diagnostic interface is never
> cleaned up when netdev goes down so DBus calls can still be made
> which ends up crashing since the AP interface objects are no longer
> valid.
> 
> Running the following iwctl commands in a script (once or twice)
> triggers this crash reliably:
> 
> iwctl device wlp2s0 set-property Mode ap
> iwctl device wlp2s0 set-property Mode station
> iwctl device wlp2s0 set-property Mode ap
> iwctl ap wlp2s0 start myssid secret123
> iwctl ap wlp2s0 show
> 
> ++++++++ backtrace ++++++++
> 0  0x7f8f1a8fe320 in /lib64/libc.so.6
> 1  0x451f35 in ap_dbus_get_diagnostics() at src/ap.c:4043
> 2  0x4cdf5a in _dbus_object_tree_dispatch() at ell/dbus-service.c:1815
> 3  0x4bffc7 in message_read_handler() at ell/dbus.c:285
> 4  0x4b5d7b in io_callback() at ell/io.c:120
> 5  0x4b489b in l_main_iterate() at ell/main.c:476
> 6  0x4b49a6 in l_main_run() at ell/main.c:519
> 7  0x4b4cd9 in l_main_run_with_signal() at ell/main.c:645
> 8  0x404f5b in main() at src/main.c:600
> 9  0x7f8f1a8e8b75 in /lib64/libc.so.6
> +++++++++++++++++++++++++++
> ---
>   src/ap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

