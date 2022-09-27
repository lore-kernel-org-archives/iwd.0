Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDA7E
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 03:53:50 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id n83so10573154oif.11
        for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 20:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date;
        bh=UMZtVAXYUz89YkpmRobqzCz+AKN2Xhg/u2VAksBpFoE=;
        b=DF06ALBVSihrv5TfEHR3XYz9uMEMXZ+uotC4JGvC9N0HdcGnogVAc/I0YbasAZ1GVa
         kc0svAz5cqkhTXHloWmtwsKOVvyQomlpy70p8ZrRYUi67OXboZrfgVZDGOEw84nxwIpN
         /t+uB5VivSANAhyoKlARsHcSLwSffCyTEdbhE++snQfuESuIC2nYujk9Os4Yds2yZICW
         eFTiNoJjEfrAx2jBPNo8yDmvNp2M6fePJYtO8gTSpGF8TG9YZRCVpLnZIjlVVRvVIpZV
         wwrVsxAl1oHjrmzbSCZUiAR6bRVoMiPJtKhJ92DebYaNjT0tnBY79uh9ZNZeywTi7bYP
         hCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date;
        bh=UMZtVAXYUz89YkpmRobqzCz+AKN2Xhg/u2VAksBpFoE=;
        b=1xoH288B+qz2tOpwmepM1LBBqpEINNZaxusciTh0sbTZpb9IURpuElV9LBEbbZuTx1
         4Q7bQufO1ysghl2vf6Uq0G771ciK4N3knbJqo/u7zQH6jbWZmTFqPxi2kNKPxI8eyei8
         KBJKnRJJmCsEJwXnKf1iH3ACCVdUF1G4wvP+cgLYjZhh8q8mstdBQTf4+Kn7ywATpaxl
         1H2Jg4J1hhFuqyPP7SX9lDTTt7r1iy+82S9zDxFhFZDGfyM6CJ+Z2UQ393ZEJuMAchNq
         HDLtDguin/NbObQnFMhS3z2UhIsX9YD9eKZZxWztHxDawm7bQLI7ApkZVvVdQirzpb3u
         KoCg==
X-Gm-Message-State: ACrzQf3TUxkCLa6JoSO/y2thYN8/mhsBhzNLFyxrelxBmT+dIGCyO+WC
	S9CdsPXSFy/ppqEAG/OZlb0YiKZArZc=
X-Google-Smtp-Source: AMsMyM7BtMe5dtG+hr38qAJRpwnKqBxesw7y6C2URiEw1NUlB1rm4xA+lA/LiC1rE7TlYyBkGzxO6w==
X-Received: by 2002:aca:2215:0:b0:350:37b4:c55 with SMTP id b21-20020aca2215000000b0035037b40c55mr891047oic.210.1664250829800;
        Mon, 26 Sep 2022 20:53:49 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y6-20020a9d2286000000b00616e2d2204csm153052ota.21.2022.09.26.20.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 20:53:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------D00plyAjwb60N1qQYq5yiwUA"
Message-ID: <d741365d-e97e-57a1-2521-40e921edbdbb@gmail.com>
Date: Mon, 26 Sep 2022 22:53:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: IWD dhcp issue?
Content-Language: en-US
To: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <PAXPR01MB9217E777D1480543FFEC84B5F4529@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <PAXPR01MB9217E777D1480543FFEC84B5F4529@PAXPR01MB9217.eurprd01.prod.exchangelabs.com>

This is a multi-part message in MIME format.
--------------D00plyAjwb60N1qQYq5yiwUA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 9/26/22 17:21, Johnson, Bryce wrote:
> Hi All,
> I trying to track down an issue that may be related to IWD DHCP (or maybe a buggy router?).  I got 2 devices on the same router one with IWD 1.29 and using the IWD DHCP (EnableNetworkConfiguration=true).  Another with IWD 1.30 with DHCPCD and EnableNetworkConfiguration disabled.
> 
> For the IWD DHCP one:
> 
> I am getting these Received Deauthentication event several times and also saw one authentication timed out.

This seems like the card firmware just decides to disconnect us.  The reason 
code of '4' translates to Inactivity Timeout.  Why it does this, ask the 
firmware vendor.

The Authentication timeout -> no idea.  AP out of range?  Hard to say.

<snip>

> with IP config it still showed the 192.168.1.7 address (that is wrong for the AP it moved over to)

So looks like we never cleaned up the address.

<snip>

> 
> I am able to ssh/ping either address and they both work.  I assume the valid_lft forever here is OK because that is kept track internally with IWD DHCP?

Yes, correct.  We do not set lifetimes for these into the kernel and just track 
them internally.

<snip>

So from your long version of the log:

> 2022-09-22 17:31:54.874541013  [DHCPv4] l_dhcp_client_stop:1247 Entering state: DHCP_STATE_INIT
> 2022-09-22 17:31:56.233417596  [DHCPv4] l_dhcp_client_start:1202 Entering state: DHCP_STATE_SELECTING
> 2022-09-22 17:31:56.859134554  [DHCPv4] dhcp_client_handle_offer:796 Entering state: DHCP_STATE_REQUESTING
> 2022-09-22 17:31:57.215529929  [DHCPv4] dhcp_client_receive_offer:777 Server sent another offer, using it instead

For some reason the DHCP server sends us two offers?  We pick the most recent one.

> 2022-09-22 17:31:57.215894013  [DHCPv4] dhcp_client_handle_offer:796 Entering state: DHCP_STATE_REQUESTING
> 2022-09-22 17:31:57.216082054  [DHCPv4] dhcp_client_rx_message:898 Entering state: DHCP_STATE_BOUND
> 2022-09-22 17:31:57.218336596  [DHCPv4] dhcp_client_rx_message:931 T1 expiring in 43200616 ms
> 2022-09-23 05:22:46.891765261  [DHCPv4] dhcp_client_t1_expired:619 Entering state: DHCP_STATE_RENEWING

Then we go to renew...

> 2022-09-23 05:22:47.241523016  [DHCPv4] dhcp_client_rx_message:882 Received NAK, Stopping...

And the DHCP server doesn't let us keep the old address?  That seems kind of 
weird.  This is probably why we never delete the .7 address.  DHCP server wants 
us to use something else.  Guess we should probably log the address we're using 
in the 'BOUND' debug message.

Can you try the attached patch (against ell) and see if that fixes this issue?

Regards,
-Denis
--------------D00plyAjwb60N1qQYq5yiwUA
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-dhcp-Send-LEASE_EXPIRED-in-case-RENEW-gets-NAKed.patch"
Content-Disposition: attachment;
 filename*0="0001-dhcp-Send-LEASE_EXPIRED-in-case-RENEW-gets-NAKed.patch"
Content-Transfer-Encoding: base64

RnJvbSAzOWM3ZGQ1MTlmMzFkNjE0MmUzZmRjMmViZGYwODQ1OGQwNGY0NzUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEZW5pcyBLZW56aW9yIDxkZW5rZW56QGdtYWlsLmNv
bT4KRGF0ZTogTW9uLCAyNiBTZXAgMjAyMiAyMjo0MjozNSAtMDUwMApTdWJqZWN0OiBbUEFU
Q0hdIGRoY3A6IFNlbmQgTEVBU0VfRVhQSVJFRCBpbiBjYXNlIFJFTkVXIGdldHMgTkFLZWQK
CkluIGNhc2UgdGhlIERIQ1Agc2VydmVyIE5BS3Mgb3VyIHJlcXVlc3QsIGRoY3BfY2xpZW50
IHdvdWxkIGFsd2F5cyBzZW5kCmEgTk9fTEVBU0UgZXZlbnQuICBIb3dldmVyLCB0aGlzIGNv
dWxkIHJlc3VsdCBpbiBhZGRyZXNzZXMgbm90IGJlaW5nCmNsZWFuZWQgdXAgcHJvcGVybHku
ICBJbiBjYXNlIGEgUkVORVcgb3IgYSBSRUJJTkQgcmVxdWVzdCB3YXMgTkFLZWQsCnNlbmQg
YSBMRUFTRV9FWFBJUkVEIGV2ZW50IGluc3RlYWQuCi0tLQogZWxsL2RoY3AuYyB8IDYgKysr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2VsbC9kaGNwLmMgYi9lbGwvZGhjcC5jCmluZGV4IGFmZDVjMzRmMzg5
YS4uOWI0MDE3MjJjY2FlIDEwMDY0NAotLS0gYS9lbGwvZGhjcC5jCisrKyBiL2VsbC9kaGNw
LmMKQEAgLTgyMCw2ICs4MjAsNyBAQCBzdGF0aWMgdm9pZCBkaGNwX2NsaWVudF9yeF9tZXNz
YWdlKGNvbnN0IHZvaWQgKmRhdGEsIHNpemVfdCBsZW4sIHZvaWQgKnVzZXJkYXRhLAogCWNv
bnN0IHZvaWQgKnY7CiAJaW50IHIsIGU7CiAJc3RydWN0IGluX2FkZHIgaWE7CisJZW51bSBs
X2RoY3BfY2xpZW50X2V2ZW50IGV2ZW50ID0gTF9ESENQX0NMSUVOVF9FVkVOVF9MRUFTRV9F
WFBJUkVEOwogCiAJQ0xJRU5UX0RFQlVHKCIiKTsKIApAQCAtODc0LDYgKzg3NSw4IEBAIHN0
YXRpYyB2b2lkIGRoY3BfY2xpZW50X3J4X21lc3NhZ2UoY29uc3Qgdm9pZCAqZGF0YSwgc2l6
ZV90IGxlbiwgdm9pZCAqdXNlcmRhdGEsCiAJCQlkaGNwX2NsaWVudF9oYW5kbGVfb2ZmZXIo
Y2xpZW50LCBtZXNzYWdlLCBsZW4pOwogCQkJcmV0dXJuOwogCQl9CisKKwkJZXZlbnQgPSBM
X0RIQ1BfQ0xJRU5UX0VWRU5UX05PX0xFQVNFOwogCQkvKiBGYWxsIHRocm91Z2ggKi8KIAlj
YXNlIERIQ1BfU1RBVEVfUkVORVdJTkc6CiAJY2FzZSBESENQX1NUQVRFX1JFQklORElORzoK
QEAgLTg4Miw4ICs4ODUsNyBAQCBzdGF0aWMgdm9pZCBkaGNwX2NsaWVudF9yeF9tZXNzYWdl
KGNvbnN0IHZvaWQgKmRhdGEsIHNpemVfdCBsZW4sIHZvaWQgKnVzZXJkYXRhLAogCQkJQ0xJ
RU5UX0lORk8oIlJlY2VpdmVkIE5BSywgU3RvcHBpbmcuLi4iKTsKIAkJCWxfZGhjcF9jbGll
bnRfc3RvcChjbGllbnQpOwogCi0JCQlkaGNwX2NsaWVudF9ldmVudF9ub3RpZnkoY2xpZW50
LAotCQkJCQlMX0RIQ1BfQ0xJRU5UX0VWRU5UX05PX0xFQVNFKTsKKwkJCWRoY3BfY2xpZW50
X2V2ZW50X25vdGlmeShjbGllbnQsIGV2ZW50KTsKIAkJCXJldHVybjsKIAkJfQogCi0tIAoy
LjM1LjEKCg==

--------------D00plyAjwb60N1qQYq5yiwUA--
