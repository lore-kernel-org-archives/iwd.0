Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2C33D4
	for <iwd@lists.linux.dev>; Sun,  7 May 2023 23:04:45 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6a5e2289965so2708196a34.3
        for <iwd@lists.linux.dev>; Sun, 07 May 2023 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683500684; x=1686092684;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsmtrp1L3wGtGjPlOpAwhVBXDRgAdkjWbmIsFfr0Jzk=;
        b=poa74RhIupS3LSNdAcOHYN32lmOL5k4pCxFC9o+iG+sTK8Yz43Cbf8I7Az2Ia67Y71
         4EoI8fSkqsXVxhvxCkmR5KbidIZjJZk7WZy7xZd7WEFfDbz41R7h34mSsQLZjRcw1ZGM
         GaFHP70f99AkXadeC4qAVKYpbsjsmZc2H4lqvDrNug0+fCzJ9uzrjNYNupA0AW+Fe1zh
         WehUt85OmtsyVOs2Dh3rzYF69iLDAbxL83pb3ymamA8IpW8GWgzKQ3nZVBlm4LYtDNBa
         UOGa0HVXyGgkPDIzrYcQMWyaXOPiwcqisWuZ/hDHNbk8b7r3IEL9GVBruYZxtYGK5k8I
         XkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683500684; x=1686092684;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsmtrp1L3wGtGjPlOpAwhVBXDRgAdkjWbmIsFfr0Jzk=;
        b=Ir/c3EDoU35QimyB8Ar0LXdEVtPB1mtZ8JptHGHJ1VoFAPxqeS7d304itIqqEILXsT
         Lwn1+65w9qIq8N6bBEuD5RE+f/91Qg0XQLxVEDXyezv2Bblz8DMd3etAq3zuz1fEyVNF
         Vidq9fVVD0amExDRaGcRCdDc5Xa1grpH+Ll/8dmdV+yMy+lR03jRg1PYySRRFhZtF+KZ
         2cLfvkBfYfNWsJ/TPGvxndz8EZT6l1qZsI867/evO0tJ0F8562sI+K5WXlvZZBTqoYEX
         HONPdryWC3r+zS3UXHXbGgPIqrjwHtp4tyFmHwf9xz+oabVxUgTgAcLE3mAwBwEQLxp1
         FmNg==
X-Gm-Message-State: AC+VfDy7d4KU+XC/PJSw5tFKsXiNy9oLfdpk1mdWv/mommfOfgWKe9le
	KVnbdt/I8MfNBUPQgP0Q+jZSoT4NSAg=
X-Google-Smtp-Source: ACHHUZ6Nw5CaYwa7glTsB2h3Xrdmf34ZKhaVjFcYzpIVNhnM/V9JHcN/tGJR+KOQ5reVXKf0gtWmTA==
X-Received: by 2002:a05:6808:b15:b0:389:92d6:18a1 with SMTP id s21-20020a0568080b1500b0038992d618a1mr4198613oij.24.1683500684051;
        Sun, 07 May 2023 16:04:44 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cv20-20020a056808261400b003923e412668sm5003344oib.50.2023.05.07.16.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 16:04:42 -0700 (PDT)
Message-ID: <1417ed78-7ddd-3725-63b6-34d2923122e8@gmail.com>
Date: Sun, 7 May 2023 18:03:55 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] client: avoid segfault in iwctl quit
Content-Language: en-US
To: Ronan Pigott <ronan@rjp.ie>, iwd@lists.linux.dev
References: <20230502084831.60016-1-ronan@rjp.ie>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230502084831.60016-1-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ronan,

On 5/2/23 03:48, Ronan Pigott wrote:
> iwctl quit (running quit non-interactively) isn't a useful command,
> but it shouldn't segfault. Let's avoid calling readline functions if
> we haven't initialized readline in this run.
> ---
>   client/display.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Regards,
-Denis

