import argparse

def main() -> int:
    parser = argparse.ArgumentParser(
        prog="vou-de-taxi",
        description="vou de taxi - PySpark pipeline (skeleton)"
    )
    parser.add_argument("--taxi", default="yellow", help="taxi type: yellow/green (future)")
    parser.add_argument("--from", dest="from_month", default="2019-01", help="YYYY-MM")
    parser.add_argument("--to", dest="to_month", default="2019-12", help="YYYY-MM")
    parser.add_argument("--mode", default="skip", choices=["skip", "overwrite"], help="idempotent mode")
    args = parser.parse_args()

    print("vou de taxi (skeleton)")
    print(f"taxi={args.taxi} from={args.from_month} to={args.to_month} mode={args.mode}")
    print("Next: implement pipeline stages in vou_de_taxi/...")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
