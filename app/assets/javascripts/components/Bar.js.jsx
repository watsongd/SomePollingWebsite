var SetIntervalMixin = {
  componentWillMount: function() {
    this.intervals = [];
  },
  setInterval: function() {
    this.intervals.push(setInterval.apply(null, arguments));
  },
  componentWillUnmount: function() {
    this.intervals.forEach(clearInterval);
  }
};

var Bar = React.createClass({
  mixins: [SetIntervalMixin],
  getInitialState: function() {
    return {
      myBarChart: null,
      labels: this.props.labels,
      data: this.props.data,
      backgroundColors: this.props.backgroundColors,
      borderColors: this.props.borderColors,
      id: this.props.id
    }
  },
  getUpdatedData: function(e) {
    $.getJSON("/api/v1/polls/" + this.state.id,
      function(json) {
        var newData = new Array();
        for (var key in json.options) {
          newData.push(json.options[key]);
        }
        this.setState({data: newData});
      }.bind(this)
    );
    this.state.myBarChart.data.datasets[0].data = this.state.data;
    this.state.myBarChart.update();
    this.setState({});
  },
  componentDidMount: function() {
    setInterval(this.getUpdatedData, 10000);
    var ctx = document.getElementById("myBar").getContext("2d");
    var myBarChart = new Chart(ctx,{
      type: 'bar',
      data: {
        labels: this.state.labels,
        datasets: [
          {
            label: "Responses",
            data: this.state.data,
            backgroundColor: this.state.backgroundColors,
            borderColor: this.state.borderColors,
            borderWidth: 1
          }
        ]
      },
      options: {
        scales: {
          yAxes: [{
            ticks: {
              min: 0
            }
          }]
        },
        legend: false
      }
    });
    this.setState({myBarChart: myBarChart});
  },
  render: function() {
    return(
      <div></div>
    )
  }
});