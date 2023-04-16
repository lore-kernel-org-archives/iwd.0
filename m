Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976284A32
	for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 18:14:42 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-18779252f7fso15928008fac.12
        for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681668881; x=1684260881;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcKia4/ZdYQyG3xV9EeFJb/NqdkOMjsa50kLFsowyuE=;
        b=lqSZHW3OIkj3iQVJVZfDN8rwPsWATQ2SWYpVTUTuKBqqOu4RV/owcctHbUR0iCFizf
         W0BIjFlqAPr8Vw53Gv3O+7u5pa5BsU1dJWQnnF/HHLJ4bIt1jLS+ZMu0tyotgSDcp3fy
         gW8mt+kikbudw31dVL9Mt1plhc6CKIPQPb5qKzSutAujMommh5Szzwl0q5Q8KIVZ0YhM
         CsSX8VW1B8pomE85sKgE7B5bAZMNtWdOgwB29tukfAQCRi8GIa5Nc7xyT+iBRdcxEKP2
         I51QG2BNQrpDmGLuYmCtF3ZO/LoLixoXC2QByosNGGbFzsUZ68jKZQKAsdj4v3e8SkAC
         GNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668881; x=1684260881;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcKia4/ZdYQyG3xV9EeFJb/NqdkOMjsa50kLFsowyuE=;
        b=eo9dwgZvtYkU/WvDpSMh9co2vnoDWaOS/U0Wz/pWrp0vppHFrccWr7c0fWQkg9ugf5
         j58RAT2eqmaBbFb6Cb5TUm+NTF6WidlmBk3pOCfJ1Z3DXNd0XqGsft6sgZ3PmdzO4/lf
         exlTxAcFAMES8TCZnJOlrS2T15/J4u8ad5djKZ+9TjMnM9h8zJdrQ63k/cJAypyihPVj
         33NtgJiE5B0fJ01f8nhljvSMTikBzi17wtMoQAhLcUSTVVJW3gFk1gRLHZUENnhV3yq5
         CO/MiUhxxs6vmKsjDngXOl5XeUb1mOE+FFLeacb1jbQSC517hVdVr82LaFcrhi/iS2HQ
         tEyQ==
X-Gm-Message-State: AAQBX9c4ltMmbxuX0zlBjgWSerukrKrV3G8ibGeQLcHM1Rygf6KEMzsL
	ZsfhPm2PK8vpQadsW8FrjcO5AWk50vNUnw==
X-Google-Smtp-Source: AKy350ae3mcdaxLmtN8vusdqS45R+H1fNTEkVd0eE9t4HuhkVFBqZzdUt9/ykIvEUrcp3xQSsTFsdw==
X-Received: by 2002:a05:6871:592:b0:177:c62f:b059 with SMTP id u18-20020a056871059200b00177c62fb059mr7914974oan.49.1681668881719;
        Sun, 16 Apr 2023 11:14:41 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y138-20020a4a4590000000b0052c27aa1c80sm2704183ooa.46.2023.04.16.11.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:14:41 -0700 (PDT)
Message-ID: <c1cf8287-751d-f31a-5588-f9b8c7ff68e6@gmail.com>
Date: Sun, 16 Apr 2023 11:30:50 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] eapol: relax (but warn) on secure bit check in handshake
 1/4
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230410180049.180133-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230410180049.180133-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/10/23 13:00, James Prestwood wrote:
> Hostapd commit bc36991791 now properly sets the secure bit on
> message 1/4. This was addressed in an earlier IWD commit but
> neglected to allow for backwards compatibility. The check is
> fatal which now breaks earlier hostapd version (older than 2.10).
> 
> Instead warn on this condition rather than reject the rekey.
> 
> Fixes: 7fad6590bd ("eapol: allow 'secure' to be set on rekeys")
> ---
>   src/eapol.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Regards,
-Denis

