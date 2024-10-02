Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21F1DA610
	for <iwd@lists.linux.dev>; Wed,  2 Oct 2024 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892867; cv=none; b=iduaSGqa/mnFxEQXOOTjWHmy31mlt494SbB7DSihRb3CAGzuZ/6xjgp9U2nlc5q2oFg5M/0YrdukIF7+tqpKVlKSTqXb5zG6wslbj+l28if/yCpoRauAliCTQDf2hJAiITugIixG1UvIncSUQLQ3YZiHkrMzFM2lhmJlJEZqbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892867; c=relaxed/simple;
	bh=+vQhIGTnDfbdQsjcwkxoGqV/CkwEoA6ESkEVKgMDcUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yn/ZC1BrUd3+Ilk+75rnm+UU4jYCW8GHu0O1wHzODMTyPLW2skGOJUCkzPsCBkyTNZtAUiy70H93zPlpq5rNSeaapRXMRJ0Z37V96dd1WPXS2Nxbpb83LelDN3VlIBg4iJR+Ljq4YK9eIbSVavhPuxr2bR1W1rYiXXa+xcqDq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd/3hH8t; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd/3hH8t"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e5568f1baaso70589eaf.2
        for <iwd@lists.linux.dev>; Wed, 02 Oct 2024 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727892865; x=1728497665; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpVrjEtRQDrtR3h9QSoM+IYitfAMv3SJO3YmYW1jqEg=;
        b=Cd/3hH8tdLhgbY+t8Jb4dvoEeqm/gHirrQ4xo8YcGvS8HPOCtpnPiTe64NrqIg//Do
         s6/e4/YDLTxNPvkJre+n4gWzqDvKNQYvQNuqCqzgiwnGFK6ng9q3Nmjhux3IIiRORobY
         u6SlwSvtE3FZ3XwlkLRaBToahGNYxLkev7bvp5UyVjawehS/zB3TGSHilKa+o+8Z3Clf
         yvkXN3xIsLOWB0FdnC7hqJFetT9EdbNMFCh5SyfEAjteq323FNCLyu8EsFOJjGvqLG1G
         LxN560r1UM/P7LgXIT6q1wq2+rJTUMO7crt9NocrMkqHC9xk7I3lLkg1PI1eE9VPnOz6
         exyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727892865; x=1728497665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpVrjEtRQDrtR3h9QSoM+IYitfAMv3SJO3YmYW1jqEg=;
        b=hfzN9YSEcxUKFaJJmLwO+dvxU8qNRhKZPe8pw3RBJqS98UdV8BzV7pr6Jye6uqZrp8
         EVdU+9W0iGvlG/n4FhppcWDiavOnqeSm1AGnSqDgBU/fMrmM5uKfIV2fN+FhLyBMUfyi
         6VRCUNmPqgTWdSJm6ZXO5vBiLoq/MOnusHw4IBDm/9I7h18OgoK3NWm/jmj4gQGv9RNe
         DCCq5DWaab+1RmbLhT52hnxMRkBKOVPJIFfD4aszFroAqFjr5Vfr9S/VN8qOpexrSw+2
         yg9tLyUhlXRzJ05w/1iD7FTXgux+a+QtFL5fy3lmZ4QIQR2U9J68b6jSODTbHGxBQ0kZ
         r4mA==
X-Forwarded-Encrypted: i=1; AJvYcCXFn/uyWr2AqBVUXbOwK+Z+P92z10MccQ5ODPIfKwwL+H1DD/xNR0/KQVer4Y7BmjO7OD8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxWvfnlc/f1FQo5ZIrvXoOXs2Zq8e7g7ipzNjJjvjVCBeow8qjz
	KvBy+5N7nuRigU+562h6C4Hpm3tw9qM2EvDqAP0g5VFySrL6T/u1
X-Google-Smtp-Source: AGHT+IGq9rmu/Sfx5nJ4TzksHkWBxhwmeKnB07oYQ/Lx3GxgTmjKd4l90oy8a7ieIS3F3PMCXVs9uQ==
X-Received: by 2002:a05:6820:2901:b0:5e1:cd24:c19c with SMTP id 006d021491bc7-5e7b1bb9e39mr3891612eaf.0.1727892865151;
        Wed, 02 Oct 2024 11:14:25 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-5e770dc460asm3471893eaf.16.2024.10.02.11.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:14:24 -0700 (PDT)
Message-ID: <f234b143-63f6-4184-b97a-bfaa082d8cf6@gmail.com>
Date: Wed, 2 Oct 2024 13:14:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interop problem with Quantum Fiber WiFi7 pods (duplicate RSNXE
 IE)
To: Vivek Das Mohapatra <vivek@collabora.com>, iwd@lists.linux.dev
References: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <26febdbb-1184-46be-989b-45aace86f104@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vivek,

On 10/2/24 12:08 PM, Vivek Das Mohapatra wrote:
> Hi - we've had reports of an incompatibility between network manager and
> the wifi7 hardware mentioned when using iwd as the backend.
> 
>  From what we've been able to tell:
> 
> validate_mgmt_ies() fails
> cause: disallowed duplicate IEs in the AssocResponse frame
> 
> We appear to have two dupes:
> 
> 221 - IE_TYPE_VENDOR_SPECIFIC - allowed
> 244 - IE_TYPE_RSNX - not allowed as a dup.
> 
> We checked IEEE 80211-2020.pdf couldn't find specific details about IEs
> that can be duplicated vs the ones that can’t.
> [ Sections 9.4.2.1 and 9.4.2.241 ]

Refer to section 9.3.3.1:
"The frame body consists of fields and elements as defined for each management 
frame subtype. All fields and elements are mandatory unless stated otherwise. 
Fields and elements appear in the specified, relative order, skipping fields or 
elements that are not present. STAs that encounter an element ID they do not 
recognize in the frame body of a received Management frame ignore that element 
and continue to parse the remainder of the management frame body (if any) for 
additional elements with recognizable element IDs."

IEs that allow duplication are explicitly called out:
"Vendor Specific
One or more Vendor Specific elements are optionally present. These elements 
follow all other elements."

Why are the elements duplicated?  Are they the same or different?  If different, 
which one would iwd use?

> 
> We've tried various devices and software combinations (linux and non)
> and it seems to be an interop problem with iwd specifically - we think adding 
> IE_TYPE_RSNX to the allowed dups list in validate_mgmt_ies should
> do the trick.

How about fixing the firmware?

Regards,
-Denis
