Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54F882F
	for <iwd@lists.linux.dev>; Mon,  3 Apr 2023 22:35:29 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id x15so28647435pjk.2
        for <iwd@lists.linux.dev>; Mon, 03 Apr 2023 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRD+qiQKIY11j3swk0yFdD2tRX0qrk7M4QV+7DZduGQ=;
        b=Gtcn1Cr0XDzd7khdrpA+GOXKPwbbPKimTUBl/RtPNNJ53e3wPG0qhRd6LaNGFMnrsU
         RgJS2yVvRyKy8yWutZM/2dnlmYJN+5x7cVZM2XVTb1yh+Ks5dGwRK9fc7VXKgyYp+FtT
         ar7rxTIWtHCuA8UDANaikWiSPFX7pGuXFLEgRCpl3iOrn02STV8w1RS/xbI/g4KOx3A6
         SXgmq7rE+V1VUPDJ8xdCr9gNjqUj1qdoarIgG4p6o17zCs/QQAP0UY9s3Je6wqgiXJuA
         yRwqxmStGZHOvpAaIQfZzxozJQFrt3HgVVoFuZISHKZ0j2CHUBCJFr/SUsZVAndr/S6y
         qfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRD+qiQKIY11j3swk0yFdD2tRX0qrk7M4QV+7DZduGQ=;
        b=fVqasduvvIDU9PpbZblI8DJmDURfddJR55yGXfNsorh+Llr7pLgRkBj4u9B6MswmzE
         5PDvQnyvi92bpqMLJ0jVI0tD+uCwiTAH4KvFE0buq9Z3uYMB1dvabdhATOAIK9qId4mu
         JGv5tsehQ+bk8sl1cigGV1qF+XCXXu+OgbfPOwTo4lBTtYFlm+Ddiuq1We9svwgYJfJi
         1+OVfCmzzqzT1aMZlZa0BVFbVBv7PD05bFj+nnDIbturrRG6mQQ5xyh9zATHSCWGdJFd
         UMbpycuvdxcXm5b0Yo0DIQY+9aNOwAGAbARyImI2/4BWVyxxpf0Bl00v+3tTo8xVTCUA
         iRGA==
X-Gm-Message-State: AAQBX9f+15l38cQRtGGAz620vllQKzmnZyNY9PTUs58cMPV+AxXF7685
	LSGjpAswxYAAVv0dzM/bnwk=
X-Google-Smtp-Source: AKy350bdjhQ9umj8SozsIP3d+MSUTYSXfs7oa1z/igpEktkVzemo4f1ids17UJLjIHcHl07k9DXLgA==
X-Received: by 2002:a17:903:2845:b0:19e:e39b:6d98 with SMTP id kq5-20020a170903284500b0019ee39b6d98mr477135plb.35.1680561328944;
        Mon, 03 Apr 2023 15:35:28 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001a064282ce5sm7088182pll.294.2023.04.03.15.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:35:28 -0700 (PDT)
Message-ID: <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
Date: Mon, 3 Apr 2023 15:35:28 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>, iwd@lists.linux.dev
Cc: dika@bang-olufsen.dk, clca@bang-olufsen.dk,
 =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
References: <20230403141927.235014-1-alvin@pqrs.dk>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20230403141927.235014-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 4/3/23 07:19, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
>
> The blamed commit clobbered the non-FT (Reassociation) roaming case
> in the disconnect event handler, causing iwd to potentially get stuck in
> the ROAMING state after a failed reassociation during non-FT roaming.
> Add it back.
>
> The subject is inspired by a previous commit which did the same thing,
> but introduced before the new roaming states were added, namely commit
> 8758cc89487b ("station: handle ROAMING state in disconnect event"). The
> rationale here is the same.
>
> Fixes: edf556cc7bb9 ("station: add two new roaming states (FT/FW)")

IIRC leaving out the old ROAMING state in this switch was actually done 
intentionally. This is because netdev_reassociate() takes a callback and 
any failures with the roam *should* show up in netdev_connect_event(), 
and in turn call the callback which then leads to the same 
station_disassociated() call. We wanted to avoid the potential of a 
disconnect event AND the connect callback both calling 
station_disassocated().

Do you happen to have an iwmon pcap/log of this behavior? If its a 
kernel bug and a CMD_CONNECT connect event never comes then we probably 
do need this patch, but maybe instead with an L_WARN_ON or a big debug 
print because it really shouldn't be happening.

Thanks,

James

> ---
>   src/station.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/src/station.c b/src/station.c
> index d5650a2995a9..69f9be79880d 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -3201,6 +3201,7 @@ static void station_disconnect_event(struct station *station, void *event_data)
>   					event_data, station);
>   		return;
>   	case STATION_STATE_CONNECTED:
> +	case STATION_STATE_ROAMING:
>   	case STATION_STATE_FT_ROAMING:
>   	case STATION_STATE_FW_ROAMING:
>   		station_disassociated(station);
