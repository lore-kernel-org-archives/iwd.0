Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945BBA22
	for <iwd@lists.linux.dev>; Tue, 12 Mar 2024 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213138; cv=none; b=q6CpN+I4k2zxRgOeRnRqYThmg9qUkIGEdLhDzUhUvQgKH5uV5l9W0GU0UE6Hh8+/Rokc7Heny2QTB1USjK2Uu2YdN9xbzE3rGTwEgppjIuvh9oyJVj4VW2lCu0GAk0zKySpFj2qKiQSy2+VF1Vxs/yjqoYC+akrCkk+6p+1txZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213138; c=relaxed/simple;
	bh=oOo9YwsP3DDeNA5+C7976GCAvTl9p+/mkZ2fuI3Tupg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f+mKD464+NKats74/TtCBXEf570UwtGVK/hhhKTlq3p1NUXeCWtphFVBAlRZvuF0UejB4qxJGO1HrQIXlNShnohNcPSORfaBUjCf3LklDB+8F5R20yknSl+UGb5IwaUG8SASj+etSE90Wtp18QLgCuxFbOEzu39/SdIl3hNV57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHPi3kyV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHPi3kyV"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-221ffba5c8bso853217fac.1
        for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 20:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710213136; x=1710817936; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckUb/oEJrN81IDrbOocA4ADF+f3kUvTbda6esXxFp+Q=;
        b=gHPi3kyVMTIr+sEI6nLypBIhRT1IxpvuL3KMuFCBOEPFRsH4lsU7FDPBHZiv9uJ3Z+
         L2T+c6RMd2eXgn62hQUxRo5N6F/9koiiH8LL474IUrn51qzsHxUJLUV5Bnyi5cQl7iun
         NKMuDSF6XvxjqiSqgKpo/bLI3k5aChQXVGfrSNmxsCdrOmyHEJvynSToMlE+ThZz1XRb
         gIl2Bqc8BAq/2Vplk2LyT9DGTsHr/0J/zCm17GnNx7qDk4NQs3y0NrlFe8vbyZd44Daw
         opGDB3RwK40cKW2ce+TCfkPF12ZGcGd4CrQjAhXv7W6FZODLXRDzkGwQcGh3LgxMZbDA
         RalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710213136; x=1710817936;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckUb/oEJrN81IDrbOocA4ADF+f3kUvTbda6esXxFp+Q=;
        b=XDbe9oA9M8ZtT+yLBBxGf+nXGQsre866K4MX/tRGqquytrYTldREAOUaFK5/2nZC+c
         gMt/DoWtW9GN2nAini7W3WWDSL7CxKyaB+5ikaUEuNNSy1OA6F384c3oHCZ+kJ8swX4b
         Gi48ThyATnL6CQZBtw3sxrjuc/fUVeOIhEdts3eTyuxgDvzmhc6km7YZdhTm0DZTXqnF
         ZmZehmzqkOKKUk8K/6o63qeQAHUsLLP7PvGJBAHWkapYExBinkCwWK/IQQdlcAPSVR4O
         M76lyQug4Jor4dFNgdTYw6F7eZ/WqeZ8athenbVRnIiY6sx+w72r+VqcM74OWcYhJIz4
         zglg==
X-Forwarded-Encrypted: i=1; AJvYcCXVaxsscj9uW4/jRt1BmG60EMwxKGQvGgrY9sIl/fKC2LsHw7VPoHoy2WtVFyzOdClRCHKowzkK/W/QmwDuQqriq/Ci
X-Gm-Message-State: AOJu0YxOccnMseZ1MaWagWzfJLua455k51v+l1cLuHPUX1dW3DvLNzST
	ZQV8c5ko7w7KY2tM15seZVsibINynvxPxszjPfxs58GWDn4lnsFyt1bH9IVD
X-Google-Smtp-Source: AGHT+IFOpnd9uOzC+LjtxKVe00chAPvXlCauKqElnVlhIZsrKQugI42IDwzO5zVE9FyGF9RnPa/Pzg==
X-Received: by 2002:a05:6871:5206:b0:220:a0b0:6d4a with SMTP id ht6-20020a056871520600b00220a0b06d4amr9664718oac.57.1710213136377;
        Mon, 11 Mar 2024 20:12:16 -0700 (PDT)
Received: from [192.168.0.50] (ip174-73-27-232.no.no.cox.net. [174.73.27.232])
        by smtp.googlemail.com with ESMTPSA id hb9-20020a056870780900b00221df0eb6f9sm1276799oab.28.2024.03.11.20.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 20:12:16 -0700 (PDT)
Message-ID: <7de63a8f-954f-4954-aa7e-ba1eb0dfbe68@gmail.com>
Date: Mon, 11 Mar 2024 22:10:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] p2p: check connected peer before processing request
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240301194056.1665549-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240301194056.1665549-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/1/24 13:40, James Prestwood wrote:
> Caught by static analysis, the dev->conn_peer pointer was being
> dereferenced very early on without a NULL check, but further it
> was being NULL checked. If there is a possibility of it being NULL
> the check should be done much earlier.
> ---
>   src/p2p.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

All applied, thanks.

Regards,
-Denis

