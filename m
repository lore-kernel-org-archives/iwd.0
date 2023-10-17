Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675534368F
	for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR/ywpwz"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so4100426a34.0
        for <iwd@lists.linux.dev>; Tue, 17 Oct 2023 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697555926; x=1698160726; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8lpJLl5em2zkSz+DYCG+nTKfC3a+GHpHXdApPnJ0Ro=;
        b=eR/ywpwzI/LQRk4z6QIDObPDstrRhL7RXhFFRCpojVZ5U9WflyWGyH0bO/NqL9MCEB
         FCaMPbyvZHLCuN0Acw3Og6XGTBCT2o6oFP6FOWsrdfzJAYSAXQKO9OxWMLrBT/vdqbmG
         c43f61K5IwCR5WpgVobsnu6eEgl18rGtD8LUXSJ0b0cx5tA8b7KXjcdBtuYgb/BFqQzw
         lsoYbI3vlI25swNoJOBr0ayRgppP72dHtysZNZPFg/FYwaOzYBEnKIOtOEjioK6RRfcQ
         QsSmLM6YZKh16fE0VLyGgnJC0wb1S9DqDWQuk311WINEyuTJO4DovLhuXJO/7klNlj3J
         55zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555926; x=1698160726;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8lpJLl5em2zkSz+DYCG+nTKfC3a+GHpHXdApPnJ0Ro=;
        b=FXVgKLhCwYx6LN0CeuUEQzxT+LJOBBc/U1y308Rfga9/3HN+GGdDshulL+0lLsRlsx
         JcEoWvHYF2bar7Nkw/o0bUFT+JokzMUFzwSz6HB4R4EodBfaryHwyykwYOMby3v/2FyT
         uADzm4bSOtEiwCTbx35izMfi+2455htzP6+DMErSjq+6z9oNKFKFmYP9gR8w0Zz501GT
         hhyyqIazAxHXb3v+7fO6de+6TvKV30Z2m8gSh8WeBgWi8Mc4msrbWpPKbDpYk/oLIxMf
         IlI+00SqtlEY2YD56xvdJn04ugtH64Nhzzn5bpVjksjL1xkKOXm/Ma/xgfQrDu9Se+Nv
         W7jQ==
X-Gm-Message-State: AOJu0YxYj8Nud9MmxYYq9UY5Iz/bbboJN2HO41ChP0X7L9F6Kr/s8uoj
	2HtkmNDahxYJVzvi1bHLGuiMXJFeSGQ=
X-Google-Smtp-Source: AGHT+IErs4YARlGFqd26dE/f2WvMKNV9LDLnu7G4U2Cr8rBrbTxjBNXk7kA9xdBfoz6/1FxBctzf7Q==
X-Received: by 2002:a05:6830:1e21:b0:6b8:9483:35ba with SMTP id t1-20020a0568301e2100b006b8948335bamr2719905otr.24.1697555926484;
        Tue, 17 Oct 2023 08:18:46 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a9-20020a9d3e09000000b006c4727812fdsm294070otd.15.2023.10.17.08.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:18:45 -0700 (PDT)
Message-ID: <b6d14d40-2225-4c83-a365-2925c76d951f@gmail.com>
Date: Tue, 17 Oct 2023 10:18:43 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] crypto: remove label from prf_plus, instead use
 va_args
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231012200150.338401-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/12/23 15:01, James Prestwood wrote:
> The prf_plus API was a bit restrictive because it only took a
> string label which isn't compatible with some specs (e.g. DPP
> inputs to HKDF-Expand). In addition it took additional label
> aruments which were appended to the HMAC call (and the
> non-intuitive '\0' if there were extra arguments).
> 
> Instead the label argument has been removed and callers can pass
> it in through va_args. This also lets the caller decided the length
> and can include the '\0' or not, dependent on the spec the caller
> is following.
> ---
>   src/crypto.c | 24 +++++++++---------------
>   src/crypto.h |  2 +-
>   src/erp.c    | 19 +++++++++++--------
>   3 files changed, 21 insertions(+), 24 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

