Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD94A32
	for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 18:14:48 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id x22so3795488oiv.10
        for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681668887; x=1684260887;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQH+lY1TcycddRvci4fnuO2028+UHW6Xm9dvfWsuIVQ=;
        b=Rd18MlnN1r/786QF0tU74cRjiuhRzZ3PhWPfSFnbPC1SdYiQ9kb70oTF5ZjLbtW5u4
         5mxdMN/Gxo8GChTcHLRzUcdxkP/EJJsbji8/JbfatCtPCI5EGsa9oL6PPz4yysusS4jZ
         /g/iFfidQaTKwirpbeHPfFL/bl7+faJviQ7AEuDtxqTb8i8fcqccv0MaLPSOnMkYl9X3
         X7UKwy3qnACoBP564KTyJQqYXKncwPb1lOudyAc2VX8hAFE+32wKNC/nmcE3fXS0I5gQ
         dnyFmqlzPIBcc2fN6D4bS8hsio1P0jBDPuQXYTnDakFcBVyERVNGbgtiS+PzSgD8HcI6
         gzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668887; x=1684260887;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQH+lY1TcycddRvci4fnuO2028+UHW6Xm9dvfWsuIVQ=;
        b=fBXYT4dmQaA9cSSE2fyWDr43708Me30MG/PyxnrCTuhBq9BRaaqtk+2dUsmgqUnSgS
         EMr8I70Yu+ip8JMw1VU9yc0bQQec5IBDD3ZXQBFRCjhnXQvtlUFzuaPFVfmpf97tHxwK
         DbqizDE6OASfUTEr8FxM3iNphpj3ul3rP1+cTn3NGivdn8+mroK1OiSvO/RSKwBGE5C/
         bzCASGHa1Jgzllt/CiHZ49R49MTShc02P4HJwH+WQoXjgpka2DiqmU65BcW/IUmy9vMH
         hjpSjmn4Ri3xpy0p/l+9kIDm5pUYmc8uMwbtOlFjTTcn6oMEzoSzPwiH7e1qUu6qS/SJ
         JSmA==
X-Gm-Message-State: AAQBX9fbOXxt/kgZ+lSP7YS1l6pcsYgh7OGk4iHCVJQRNgKLv3m/lcjt
	XYH1UfQXO+NAaGmmJPE9KQ0=
X-Google-Smtp-Source: AKy350ZQF588nlmyySp0DeZKDh8TP1UsAuvVsd6UZxk59C4FvwqcsbDbLcsB+d4mcxjxywgwvZEsGA==
X-Received: by 2002:a05:6808:4094:b0:389:f9b:2171 with SMTP id db20-20020a056808409400b003890f9b2171mr5181856oib.35.1681668887454;
        Sun, 16 Apr 2023 11:14:47 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bp13-20020a056808238d00b0038413a012dasm3819250oib.4.2023.04.16.11.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:14:46 -0700 (PDT)
Message-ID: <441c6a61-6d69-51b0-4c1c-76a3de50784b@gmail.com>
Date: Sun, 16 Apr 2023 13:01:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/9] crypto: modify crypto_derive_pmkid to take the
 hash/key length
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230410220135.373872-1-prestwoj@gmail.com>
 <20230410220135.373872-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230410220135.373872-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/10/23 17:01, James Prestwood wrote:
> The existing API was limited to SHA1 or SHA256 and assumed a key
> length of 32 bytes. Since other AKMs plan to be added update
> this to take the checksum/length directly for better flexibility.
> ---
>   src/crypto.c    | 18 ++++++++++++------
>   src/crypto.h    |  5 +++--
>   src/eapol.c     |  4 ++--
>   src/handshake.c | 11 ++++++-----
>   4 files changed, 23 insertions(+), 15 deletions(-)
> 

<snip>

> @@ -1126,10 +1127,15 @@ bool crypto_derive_pmkid(const uint8_t *pmk,
>   	memcpy(data + 8, addr2, 6);
>   	memcpy(data + 14, addr1, 6);
>   
> -	if (use_sha256)
> -		return hmac_sha256(pmk, 32, data, 20, out_pmkid, 16);
> -	else
> -		return hmac_sha1(pmk, 32, data, 20, out_pmkid, 16);
> +	switch (checksum) {
> +	case L_CHECKSUM_SHA1:
> +		return hmac_sha1(pmk, key_len, data, 20, out_pmkid, 16);
> +	case L_CHECKSUM_SHA256:
> +		return hmac_sha256(pmk, key_len, data, 20, out_pmkid, 16);
> +	default:
> +		l_error("Checksum type %u is not valid", checksum);
> +		return false;
> +	}

Just use l_checksum_new_hmac directly and avoid the switch/case.  That way patch 
3 is unnecessary.

Regards,
-Denis
