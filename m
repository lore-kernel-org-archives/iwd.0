Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651001308A
	for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 18:08:39 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-39e9d1bf835so3587226b6e.2
        for <iwd@lists.linux.dev>; Tue, 27 Jun 2023 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687889318; x=1690481318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQWV7Fvk9HK6KMnDMtcFHmc55E+EPm+NtgAIRUga3kg=;
        b=sCnHAuM0n4Ceebguh28FERzP9SZH2JUlEC15Y97zpLumZq57G0wyPyuKt8ftUTmhR6
         Zvo40EL6tV6SmesSIZwFVOtNsHwuorutcwfX63UIXKOYKVzuy0DNCByr5wbVfwGx3Get
         Z8LeVrQsEKuQ70qWELzVxMwcTLcjLHLuRuojEqJ5i0u4b+X5anW2siSQuRpfVybhYohO
         7jFlG6lgdO51ShWGhd6q3y5nKrMI+ycNNPdtL2h9C8h6oCAidPWUPIDAJvN8dWky0FiZ
         69qzrVrQiYIL8Pj9U9y9FjYJGWXVlpS2Uyv71U2XMTONu3zxa5oMJNhCKlr7bCUQQ3Pk
         EG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889318; x=1690481318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQWV7Fvk9HK6KMnDMtcFHmc55E+EPm+NtgAIRUga3kg=;
        b=eevgmyFOQJCmnMVtxV2PpPYfoapIalo3lX8CkXHqwrah2wjSgFJxVk2hERy3HCGVBm
         xAvBFFQOP+qSVOK0qkFEDcZVZDn7GZbkQSnfXM/SFQ60QZLyYGXj8ycxrdjLAsF1GedA
         yep0Se7EY77kkX0BACpfUBptWPtTc+o9YK4sxAVzI1WvWhRAdsJGX0+mlcAVExtuR3u2
         Wt7uzHy4HZPIckoUbqrkigP3kEGNAKN5yuu/w+tFeOvoaGQJJhxMXcVkha0/C2cxeBYK
         BThOwGWqvb3ddXcaWjLz1PXOnb7ndLnvERl+UVyWTaGKngXq8RXJRe0cgqesPWWI1ge+
         anSA==
X-Gm-Message-State: AC+VfDwqdYDdATol/k+SGo/3IRR2sZU+oqcP0TAS+w48xlOfF41Dd1aA
	Gpcp9EMI0HrxbFLsjbFU+ewN2h1qwEQ=
X-Google-Smtp-Source: ACHHUZ5nJlceT8ehZrfNxMmE08PVJCbt18del4Gg6/TXFPefNJpXadDSo3F/hfOzVDhDJmOmgUkknQ==
X-Received: by 2002:a05:6808:2795:b0:39c:cd8b:61f5 with SMTP id es21-20020a056808279500b0039ccd8b61f5mr26036491oib.13.1687889318189;
        Tue, 27 Jun 2023 11:08:38 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t18-20020a056808159200b003a1e7d8f38bsm1867179oiw.27.2023.06.27.11.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:08:37 -0700 (PDT)
Message-ID: <71f99f9f-03d7-cd08-6209-bfd12b84f137@gmail.com>
Date: Tue, 27 Jun 2023 13:04:38 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: iwd forgets network
Content-Language: en-US
To: James Tavares <jtavares@kvh.com>, Martin Petzold
 <martin.petzold@tavla.de>, "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

No top posting please :)

On 6/27/23 10:29, James Tavares wrote:
> You mentioned a possible power loss in your testing. If iwd is not performing an fsync() after joining the network and writing the SSID configuration file, then there is a small window of time (between when the file is written and when the filesystem is next synced) when the file can easily go missing if power is lost.

That is a good point.  iwd inherited its filesystem utilities from oFono and at 
the time ext3 was the favored filesystem.  The use of fsync was deemed 
unnecessary at that time.  open/write/close/rename sequence was deemed to be 
sufficient if I recall correctly.  It may be that this is no longer the case, at 
least for the filesystem being used here.

If anyone knows what the current state of the art is, please let us know.

Regards,
-Denis
